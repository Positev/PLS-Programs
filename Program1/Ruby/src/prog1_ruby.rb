# This is the main for Prog1.
# It invokes the run method of a FixedPointList instance

require_relative 'fixed_point_controller'

# If you want to read from a file for testing, uncomment this and put a p1.in
# file in the same folder of your project (with your source files).
# This redirects Standard Input to come from a file.
# Be sure to comment it out when you submit to the GRADER.
#$stdin.reopen("p1.in")

# Make a FixedPointList instance and invoke its run method
FixedPointListController.new.run
