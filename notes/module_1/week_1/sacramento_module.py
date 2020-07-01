import csv
import re

def open_csv(path):
    data = []
    with open(path, "r") as csvfile:
        real_estate_data = csv.DictReader(csvfile, delimiter = ",")
        for row in real_estate_data:
            data.append(dict(row))
    return data

def extract_year(date_string):
    year_pattern = r"\d{4}$"
    year, = re.findall(year_pattern, date_string)
    return year

def extract_day(date_string):
    day_pattern = r"^.{8}(\d+)\s"
    day, = re.findall(day_pattern, date_string)
    return day

def extract_month(date_string):
    month_pattern = r"^\w{3}\s(\w{3})\s"
    month_string, = re.findall(month_pattern, date_string)

    # translate string to MM representation
    months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    month_number = months.index(month_string) + 1
    month_no = ("0" if month_number < 10 else "") + str(month_number)
    return month_no

def extract_date(date_string):
    return "-".join([extract_year(date_string), extract_month(date_string), extract_day(date_string)])

def process_row(row, conversion_mapping):
    new_row = {}

    for key, value in row.items():
        if key in conversion_mapping:
            new_row[key.replace("__", "_")] = conversion_mapping[key](value)
        else:
            new_row[key.replace("__", "_")] = value

    return new_row

def export_csv(path, data):
    with open(path, "w") as outfile:
        fieldnames = list(data[0].keys())
        writer = csv.DictWriter(outfile, fieldnames = fieldnames)

        writer.writeheader()
        for row in data:
            writer.writerow(row)
