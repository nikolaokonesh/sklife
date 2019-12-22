class Article::SubscribesController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    if current_user.subscribed?
      redirect_to root_url, notice: 'Вы уже подписаны на нашем сайте.'
    else
      response = @sbrf_client.register(
        amount: params[:amountorub], # в самых мелких долях валюты
        order_number: SecureRandom.random_number(10000000000),
        return_url: success_subscribes_url,
        fail_url: fail_subscribes_url
      )
      if response.success?
        redirect_to response.form_url, allow_other_host: true
      else
        redirect_to root_url, alert: 'Ошибка. Обратитесь к администратору'
      end
    end
  end

  def success
    if current_user.subscribed?
      redirect_to root_url, notice: 'Вы уже подписаны на нашем сайте.'
    else
      status = @sbrf_client.get_order_status_extended(order_id: params[:orderId])
      if status.success? && status.order_status == 2
        sbrf_order = Article::Subscribe.where(number: status.orderNumber).limit(1)
        if sbrf_order.present? == false
          current_user.subscribes.create(
            number: status.orderNumber,
            about: "Подписка до #{Date.today + monthing_prog(status)}",
            price: amount_prog(status))
          current_user.update(subscribe_at: Date.today + monthing_prog(status))
          redirect_to root_url, notice: 'Поздравляем! Оплата успешно проведена.'
        else
          redirect_to root_url, alert: 'Данный запрос был ранее задан и обработан.'
        end
      else
        redirect_to root_url, alert: status.error_message
      end
    end
  end

  def fail
    redirect_to root_url, alert: 'Fail'
  end


  private

    def monthing_prog(status)
      if status.amount == (summ_small_month+"00").to_i
        3.month
      elsif status.amount == (summ_large_month+"00").to_i
        6.month
      elsif status.amount == (summ_largest_month+"00").to_i
        12.month
      end
    end

    def amount_prog(status) # summa perevoda
      if status.amount == (summ_small_month+"00").to_i
        summ_small_month
      elsif status.amount == (summ_large_month+"00").to_i
        summ_large_month
      elsif status.amount == (summ_largest_month+"00").to_i
        summ_largest_month
      end
    end

end
