class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[ show update destroy ]

  # GET /payments
  def index
    @payments = Payment.all

    render json: @payments
  end

  # GET /payments/1
  def show
    render json: @payment
  end

  # POST /payments
  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      render json: { folha: @payment, funcionario: @payment.employee }, status: :created, location: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payments/1
  def update
    if @payment.update(payment_params)
      render json: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /payments/1
  def destroy
    @payment.destroy
  end

  def calculate

    @payments = Payment.all
    @calculated_payments = []
    @payments.each do |payment|
      @calculated_payments << {
        mes: payment.mes,
        ano: payment.ano,
        horas: payment.horas,
        valor: payment.valor,
        employees_id: payment.employees_id,
        bruto: calculate_bruto(payment: payment),
        irrf: calculate_irrf(),  
        fgts: calculate_fgts(),
        inss: calculate_inss(),   
        liquido: calculate_liquid()    
      }
    end

    render json: {pagamentos_calculados: @calculated_payments}
  end

  private

    def calculate_bruto(payment:)
      @bruto = (payment.horas * payment.valor) 
    end

    def calculate_liquid()
      @bruto - @irrf - @inss      
    end

    def calculate_fgts
      @bruto * 0.08
    end

    def calculate_inss
      if @bruto <=  1693.72
        @inss = (@bruto * 0.08)
      elsif @bruto >= 1693.73 && @bruto <= 2822.90
        @inss = (@bruto * 0.09)
      elsif @bruto >= 2822.91 && @bruto <= 5645.80
        @inss = (@bruto * 0.11)
      elsif @bruto > 5645.80
        @inss = 621.03
      end
    end

    def calculate_irrf
      if @bruto <= 1903.98
        @irrf = 0
      elsif @bruto > 1903.98 &&  @bruto <= 2826.65 
        @irrf = (@bruto * (7.5/100))
      elsif @bruto >= 2826.66 &&  @bruto <= 3751.05
        @irrf = (@bruto * (15/100))
      elsif @bruto >= 3751.06 &&  @bruto <= 4664.68
        @irrf = (@bruto * (22.5/100))
      elsif @bruto >= 4664.69
        @irrf = (@bruto * (27.5/100))
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.fetch(:payment, {}).permit(:mes, :ano, :horas, :valor, :employees_id)
    end
end
