# Scheduler

## To-Do
- [x] Create add functions for Leave
- [x] Create add functions for Meetings
- [x] Create add functions for Programs
- [x] Repair adding the second hour in the meetingProgramLogger function
- [x] Remove people from HTML who are out for leave/meetings/programs
- [ ] Compare values of who's out to fill in empty space keeping in mind: breaktime, preference
- [x] Fix program logging, program name not working
- [ ] Compare to fill positions looking at the employee arrays for work hours (employee[i][3]-employee[i][4]) and for break start (employee[i][5]) and for break length (employee[i][6]).
- [x] compareForEmptyLoc doesn't add/sort 'JW' or 'RF', no idea why
- [ ] Fix issues for logging project time employees that end with 'til X or at X
- [ ] Figure out way to solve two lines on one position
- [ ] Do most of the hour searching through the employee's start time/end time/break time/break length variables in the employee array
- [ ] Time not logging correctly when both the first and second hour fall into the the same frame and the second hour is less than the end. It doesn't say "/'til _"

## Files

### dark-mode / light-mode
Dark mode is for development, light-mode for final.

### index.html
Contains employees at locations based on an old template from before October 2022.
### script.js
The functionality for index.html.
### scratchpad.js
Used for figuring out problems without the extra lines of code from script.js.
### README.md
Information about each file and how to use.
### tuesday-schedule-template.pdf
Schedule provided by Michelle, effective as of *October 21, 2022*.