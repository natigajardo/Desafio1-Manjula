class Baby < ApplicationRecord
    has_many :breast_feedings, dependent: :destroy

    def to_s
        name
    end 

    def total_drinking
        breast_feedings.sum(:quantity)
    end

    def total_duration
        breast_feedings.sum(:duration)
    end

    #Cantidad de veces que el bebé tomó hasta ahora
    def breast_feeding_times_today
        breast_feedings.where("created_at >= :start_at AND created_at <= :end_date", {start_at: Time.now.beginning_of_day, end_date: Time.now}).count 
    end

    #fecha de la ultima vez que bebió
    def last_time_drinking
        if breast_feedings.count > 0
            breast_feedings.last.created_at 
        else
            ''
        end
    end 

    #Por cuanto tiempo ha bebido hoy 
    def breast_feeding_duration_today 
        breast_feedings.where("created_at >= :start_at AND created_at <= :end_date", {start_at: Time.now.beginning_of_day, end_date: Time.now}).sum(:duration)
    end

    #Cuanta cantidad bebio hoy 
    def breast_feeding_quantity_today
        breast_feedings.where("created_at >= :start_at AND created_at <= :end_date", {start_at: Time.now.beginning_of_day, end_date: Time.now}).sum(:quantity)
    end


end
