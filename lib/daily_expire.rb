require 'Chronic'

module DailyExpire
  module ActiveSupport
    module Cache
      UNIVERSAL_OPTIONS << [:every, :at]
      DAYS = [:day, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

      class Store
        private
          # Merge the default options with ones specific to a method call.
          def merged_options(call_options) # :nodoc:
            @options = calc_expires_in(call_options) if call_options
            if call_options
              @options.merge(call_options)
            else
              @options.dup
            end
          end

          def calc_expires_in(options)
            if options[:expires_in].blank? && options[:every] && ActiveSupport::Cache::DAYS.include?(options[:every]) && options[:at]
              now = Time.now
              expires_in = nil

              case options[:every]
              when :day
                now_to_s = now.strftime('%Y-%m-%e')
                tmp_t    = (now + 1.day).strftime('%Y-%m-%e')
                exp = Chronic.parse(tmp_t + " #{options[:at]}")
                if now < exp
                  expires_in = Chronic.parse(now_to_s + " #{options[:at]}").to_i - now.to_i
                else
                  expires_in = exp.to_i - now.to_i
                end
              else
                if now.send("#{options[:every]}?")
                  options[:every] = :day
                  return calc_expires_in(options)
                else
                  expires_in = Chronic.parse("next #{options[:every]} #{options[:at]}").to_i - now.to_i
                end
              end
              options.merge(:expires_in => expires_in)
            else
              options
            end
          end
      end
    end
  end
end