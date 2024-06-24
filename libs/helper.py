import calendar
from datetime import datetime, timedelta

def hello_text(text):
    print(text)
    return text

def sort_list(list, order_by):
    if order_by == "ASC":
        list.sort(key = int)
    elif order_by == "DESC":
        list.sort(key = int,reverse=True)
    else:
        print("Parameters order_by support only DESC, ASC")
    return list

def get_lastdate_of_next_2_month(month, year):
    next2month = int(month)+2
    year = int(year)
    if next2month > 12:
        next2month = next2month - 12
        year = year + 1
    lastday = (calendar.monthrange(year, next2month))[1]
    lastdate = str(lastday) + "/" + str(next2month).rjust(2,"0") + "/" + str(year)
    print(lastdate)
    return lastdate

def get_last_date_of_last_month():
    today = datetime.today()
    first_day_of_current_month = today.replace(day=1)
    last_day_of_last_month = first_day_of_current_month - timedelta(days=1)
    last_day_of_last_month = last_day_of_last_month.strftime('%Y-%m-%d')
    return last_day_of_last_month

def get_future_date_from_current(number_of_next_date):
    number_of_next_date = int(number_of_next_date)
    presentday = datetime.today()
    future_date = str(presentday + timedelta(number_of_next_date))
    future_date = future_date.split()[0]
    return future_date

def get_past_date_from_current(number_of_past_date):
    number_of_past_date = int(number_of_past_date)
    presentday = datetime.today()
    past_date = str(presentday + timedelta(number_of_past_date))
    past_date = past_date.split()[0]
    return past_date

def decode_unicode_escape(text):
    return (text.encode('ascii', 'ignore').decode('unicode_escape'))

def compare_date_between_range(future_date, past_date, date):
    future_date = future_date.split("/")
    future_date = datetime(int(future_date[2]), int(future_date[1]), int(future_date[0]))
    past_date = past_date.split("/")
    past_date = datetime(int(past_date[2]), int(past_date[1]), int(past_date[0]))
    date = date.split("/")
    date = datetime(int(date[2]), int(date[1]), int(date[0]))
    return  past_date <=  date and date <= future_date
