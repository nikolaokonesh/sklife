module Article
  class SubscribesController < ApplicationController
    before_action :authenticate_user!

    def new; end

    def create
      if current_user.subscribed?
        redirect_to root_url, notice: 'Вы уже подписаны на нашем сайте.'
      else
        response = @sbrf_client.register(
          amount: params[:amountorub],
          order_number: SecureRandom.random_number(10_000_000_000),
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
              price: amount_prog(status)
            )
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
      if status.amount == (summ_short_month + '00').to_i
        1.month
      elsif status.amount == (summ_long_month + '00').to_i
        6.month
      end
    end

    # summa perevoda
    def amount_prog(status)
      if status.amount == (summ_short_month + '00').to_i
        summ_short_month
      elsif status.amount == (summ_long_month + '00').to_i
        summ_long_month
      end
    end
  end
end
