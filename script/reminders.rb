accounts = UserAccounts.all
now = Time.now
today = Date.new(now.year, now.month, now.day)

account.each do |acc|
  acc.activities.each do |act|
    act.reminders do |rem|
      if !rem.sent
        rem.sent = true
        if today > (act.done_by_date - rem.days_before)
          #Send mail!!!
        end
        rem.save
      end
    end
  end
end
