from ckanext.datapackager.lib.helpers import _csv_data_from_file

with open("ckanext/datapackager/tests/test-data/lahmans-baseball-database/ManagersHalf.csv", "rb") as csvfile:
    assert _csv_data_from_file(csvfile)["success"]