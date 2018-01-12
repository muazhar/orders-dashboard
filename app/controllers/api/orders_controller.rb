module Api
  class OrdersController < ApiController
    def index
      @orders = Order.by_state(params[:state]).order(created_at: :desc)
    end

    def create
      order = Order.new(order_params)

      if order.save
        render json: order, status: 201
      else
        render json: order.errors, status: 422
      end
    end

    def update
      order = Order.find(params[:id])

      if order.update(order_params)
        render json: order, status: 200
      else
        render json: order.errors, status: 422
      end
    end

    private

    def order_params
      params.require(:order).permit(:address, :price, :state)
    end
  end
end
