module BackLog
  class Calculator
  	#accessor
  	attr_accessor :caculation_logic
  	def initialize(caculation_logic)
      @caculation_logic = caculation_logic
  	end
    TECH_KPI_METHOD = Proc.new do |task|
                      end
    def kpi
      calculator = BackLog::Calculator.new(TECH_KPI_METHOD)
      calculator.kpi
    end

    def tech_kpi
    end

    def personal_kpi
    end
  end
end