require 'google/apis/calendar_v3'
require 'googleauth'


scope = 'https://www.googleapis.com/auth/calendar'
authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
    json_key_io: File.open("credentials.json"),
    scope: scope)

authorizer.fetch_access_token!    

service = Google::Apis::CalendarV3::CalendarService.new
service.authorization = authorizer

# calendar = Google::Apis::CalendarV3::Calendar.new(
#   summary: 'calendarSummary',
#   time_zone: 'America/Los_Angeles'
# )

# result = service.insert_calendar(calendar)
# calendar_id = result.id
# print result.id 

calendar_id = "87pupk40fjegfn7gospiu9oq34@group.calendar.google.com"
rule = Google::Apis::CalendarV3::AclRule.new(
    scope: {
    type: 'domain',
    value: 'takeofflabs.com',
    },
    role: 'reader'
)
ctr = service.insert_acl("87pupk40fjegfn7gospiu9oq34@group.calendar.google.com", rule)
puts "control rule: " + ctr.id

event = Google::Apis::CalendarV3::Event.new(
    summary: 'Tree',
    location: '800 Howard St., San Francisco, CA 94103',
    description: 'A chance to hear more about Google\'s developer products.',
    start: Google::Apis::CalendarV3::EventDateTime.new(
    date_time: '2021-12-24T09:00:00-07:00',
    time_zone: 'America/Los_Angeles'
    ),
    end: Google::Apis::CalendarV3::EventDateTime.new(
    date_time: '2021-12-24T17:00:00-07:00',
    time_zone: 'America/Los_Angeles'
    ),
    recurrence: [
    'RRULE:FREQ=DAILY;COUNT=2'
    ],
    
    reminders: Google::Apis::CalendarV3::Event::Reminders.new(
    use_default: false,
    overrides: [
        Google::Apis::CalendarV3::EventReminder.new(
        reminder_method: 'email',
        minutes: 24 * 60
        ),
        Google::Apis::CalendarV3::EventReminder.new(
        reminder_method: 'popup',
        minutes: 10
        )
    ]
    )
)
result = service.insert_event("87pupk40fjegfn7gospiu9oq34@group.calendar.google.com", event)
puts "Event created in calendar: #{result.html_link}"

calendar_id = "87pupk40fjegfn7gospiu9oq34@group.calendar.google.com"
response = service.list_events(calendar_id,
                            max_results: 10,
                            single_events: true,
                            order_by: 'startTime',
                            time_min: Time.now.iso8601)
puts 'Upcoming events:'
puts 'No upcoming events found' if response.items.empty?
response.items.each do |event|
start = event.start.date || event.start.date_time
puts "- #{event.summary} (#{start})"
end
