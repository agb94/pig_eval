import imp
import os

io_module = imp.load_source('io', 'glue/core/io.py')
io_module.extract_data_fits("examples/ha_regrid.fits")
io_module.extract_data_fits("examples/Pipe.fits")