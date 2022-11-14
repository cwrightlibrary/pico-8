/*
HOURS
off             0
08:30-17:30     1
09:00-14:00     2
09:00-17:30     3
11:00-16:00     4
14:00-20:00     5

15:30-20:00     6
16:00-20:00     7
16:30-20:00     8
17:00-20:00     9
11:00-19:00     10

BREAKTIME
no break        0
13:00-14:00     1
16:30-17:30     2
16:30-17:00     3
17:00-17:30     4
17:30-18:00     5
*/

//EMPLOYEE LIST
//let employee = [firstName, initials, rank, start-time, end-time, break-start, break-length];
let michelle = ['Michelle', 'MD', 0, '', '', '', ''];
let rod = ['Rod', 'RF', 1, '', '', '', ''];
let lea = ['Lea', 'LS', 2, '', '', '', ''];
let sonaite = ['Sonaite', 'SK', 2, '', '', '', ''];
let yami = ['Yami', 'YH', 2, '', '', '', ''];
let anthony = ['Anthony', 'AY', 3, '', '', '', ''];
let john = ['John', 'JW', 3, '', '', '', ''];
let lindsey = ['Lindsey', 'LT', 4, '', '', '', ''];
let tyler = ['Tyler', 'TE', 4, '', '', '', ''];
let jess = ['Jess', 'JB', 4, '', '', '', ''];
let steve = ['Steve', 'SL', 5, '', '', '', ''];
let raef = ['Raef', 'RM', 5, '', '', '', ''];
let chris = ['Chris', 'CW', 5, '', '', '', ''];
let shaquiella = ['Shaquiella', 'SH', 5, '', '', '', ''];
let cheryl = ['Cheryl', 'CC', 6, '', '', '', ''];
let wendy = ['Wendy', 'WJ', 6, '', '', '', ''];
let deborah = ['Deborah', 'DL', 6, '', '', '', ''];
let gwen = ['Gwen', 'GM', 6, '', '', '', ''];
let keith = ['Keith', 'KR', 7, '', '', '', ''];

let employee = [michelle, rod, lea, sonaite, yami, anthony, john, lindsey, tyler, jess, steve, raef, chris, shaquiella, cheryl, wendy, deborah, gwen, keith];

let nineMeetingsEmployees = [], elevenMeetingsEmployees = [], oneMeetingsEmployees = [], twoMeetingsEmployees = [], fourMeetingsEmployees = [], sixMeetingsEmployees = [];

//LOCATION LIST
//pickup window
let ninePUW = [document.getElementById('ninePUW'), 'ninePUW', steve];
let elevenPUW = [document.getElementById('elevenPUW'), 'elevenPUW', tyler];
let onePUW = [document.getElementById('onePUW'), 'onePUW', anthony];
let twoPUW = [document.getElementById('twoPUW'), 'twoPUW', lea];
let fourPUW = [document.getElementById('fourPUW'), 'fourPUW', raef];
let sixPUW = [document.getElementById('sixPUW'), 'sixPUW', cheryl];
//floor lead
let nineFL = [document.getElementById('nineFL'), 'nineFL', tyler];
let elevenFL = [document.getElementById('elevenFL'), 'elevenFL', lindsey];
let oneFL = [document.getElementById('oneFL'), 'oneFL', ''];
let twoFL = [document.getElementById('twoFL'), 'twoFL', steve];
let fourFL = [document.getElementById('fourFL'), 'fourFL', jess];
let sixFL = [document.getElementById('sixFL'), 'sixFL', ''];
//service point 1a
let nineSP1a = [document.getElementById('nineSP1a'), 'nineSP1a', yami];
let elevenSP1a = [document.getElementById('elevenSP1a'), 'elevenSP1a', anthony];
let oneSP1a = [document.getElementById('oneSP1a'), 'oneSP1a', lindsey];
let twoSP1a = [document.getElementById('twoSP1a'), 'twoSP1a', jess];
let fourSP1a = [document.getElementById('fourSP1a'), 'fourSP1a', deborah];
let sixSP1a = [document.getElementById('sixSP1a'), 'sixSP1a', wendy];
//service point 1b
let nineSP1b = [document.getElementById('nineSP1b'), 'nineSP1b', ''];
let elevenSP1b = [document.getElementById('elevenSP1b'), 'elevenSP1b', shaquiella];
let oneSP1b = [document.getElementById('oneSP1b'), 'oneSP1b', chris];
let twoSP1b = [document.getElementById('twoSP1b'), 'twoSP1b', raef];
let fourSP1b = [document.getElementById('fourSP1b'), 'fourSP1b', cheryl];
let sixSP1b = [document.getElementById('sixSP1b'), 'sixSP1b', deborah];
//service point 2a
let nineSP2a = [document.getElementById('nineSP2a'), 'nineSP2a', chris];
let elevenSP2a = [document.getElementById('elevenSP2a'), 'elevenSP2a', rod];
let oneSP2a = [document.getElementById('oneSP2a'), 'oneSP2a', tyler];
let twoSP2a = [document.getElementById('twoSP2a'), 'twoSP2a', john];
let fourSP2a = [document.getElementById('fourSP2a'), 'fourSP2a', wendy];
let sixSP2a = [document.getElementById('sixSP2a'), 'sixSP2a', gwen];
//service point 2b
let nineSP2b = [document.getElementById('nineSP2b'), 'nineSP2b', jess];
let elevenSP2b = [document.getElementById('elevenSP2b'), 'elevenSP2b', sonaite];
let oneSP2b = [document.getElementById('oneSP2b'), 'oneSP2b', shaquiella];
let twoSP2b = [document.getElementById('twoSP2b'), 'twoSP2b', lindsey];
let fourSP2b = [document.getElementById('fourSP2b'), 'fourSP2b', steve];
let sixSP2b = [document.getElementById('sixSP2b'), 'sixSP2b', ''];
//programs
let ninePrograms = [document.getElementById('ninePrograms'), 'ninePrograms', ''];
let elevenPrograms = [document.getElementById('elevenPrograms'), 'elevenPrograms', ''];
let onePrograms = [document.getElementById('onePrograms'), 'onePrograms', ''];
let twoPrograms = [document.getElementById('twoPrograms'), 'twoPrograms', ''];
let fourPrograms = [document.getElementById('fourPrograms'), 'fourPrograms', ''];
let sixPrograms = [document.getElementById('sixPrograms'), 'sixPrograms', ''];
//meetings
let nineMeetings = [document.getElementById('nineMeetings'), 'nineMeetings', nineMeetingsEmployees];
let elevenMeetings = [document.getElementById('elevenMeetings'), 'elevenMeetings', elevenMeetingsEmployees];
let oneMeetings = [document.getElementById('oneMeetings'), 'oneMeetings', oneMeetingsEmployees];
let twoMeetings = [document.getElementById('twoMeetings'), 'twoMeetings', twoMeetingsEmployees];
let fourMeetings = [document.getElementById('fourMeetings'), 'fourMeetings', fourMeetingsEmployees];
let sixMeetings = [document.getElementById('sixMeetings'), 'sixMeetings', sixMeetingsEmployees];
//project time
let nineProject = [document.getElementById('nineProject'), 'nineProject', ''];
let elevenProject = [document.getElementById('elevenProject'), 'elevenProject', ''];
let oneProject = [document.getElementById('oneProject'), 'oneProject', ''];
let twoProject = [document.getElementById('twoProject'), 'twoProject', ''];
let fourProject = [document.getElementById('fourProject'), 'fourProject', ''];
let sixProject = [document.getElementById('sixProject'), 'sixProject', ''];
//leave/lunch/workers (invisible)
let nineLeave = [document.getElementById('nineLeave'), 'nineLeave', ''];
let elevenLeave = [document.getElementById('elevenLeave'), 'elevenLeave', ''];
let oneLeave = [document.getElementById('oneLeave'), 'oneLeave', ''];
let twoLeave = [document.getElementById('twoLeave'), 'twoLeave', ''];
let fourLeave = [document.getElementById('fourLeave'), 'fourLeave', ''];
let sixLeave = [document.getElementById('sixLeave'), 'sixLeave', ''];
let nineLunch = [document.getElementById('nineLunch'), 'nineLunch', ''];

let locations = [ninePUW, elevenPUW, onePUW, twoPUW, fourPUW, sixPUW, nineFL, elevenFL, oneFL, twoFL, fourFL, sixFL, nineSP1a, elevenSP1a, oneSP1a, twoSP1a, fourSP1a, sixSP1a,  nineSP1b, elevenSP1b, oneSP1b, twoSP1b, fourSP1b, sixSP1b, nineSP2a, elevenSP2a, oneSP2a, twoSP2a, fourSP2a, sixSP2a, nineSP2b, elevenSP2b, oneSP2b, twoSP2b, fourSP2b, sixSP2b, ninePrograms, elevenPrograms, onePrograms, twoPrograms, fourPrograms, sixPrograms, nineMeetings, elevenMeetings, oneMeetings, twoMeetings, fourMeetings, sixMeetings,  nineProject, elevenProject, oneProject, twoProject, fourProject, sixProject];

let nineLocations = [ninePUW, nineFL, nineSP1a, nineSP1b, nineSP2a, nineSP2b, ninePrograms, nineMeetings, nineProject];
let elevenLocations = [elevenPUW, elevenFL, elevenSP1a, elevenSP1b, elevenSP2a, elevenSP2b, elevenPrograms, elevenMeetings, elevenProject];
let oneLocations = [onePUW, oneFL, oneSP1a, oneSP1b, oneSP2a, oneSP2b, onePrograms, oneMeetings, oneProject];
let twoLocations = [twoPUW, twoFL, twoSP1a, twoSP1b, twoSP2a, twoSP2b, twoPrograms, twoMeetings, twoProject];
let fourLocations = [fourPUW, fourFL, fourSP1a, fourSP1b, fourSP2a, fourSP2b, fourPrograms, fourMeetings, fourProject];
let sixLocations = [sixPUW, sixFL, sixSP1a, sixSP1b, sixSP2a, sixSP2b, sixPrograms, sixMeetings, sixProject];

let timeLocations = [nineLocations, elevenLocations, oneLocations, twoLocations, fourLocations, sixLocations];

let nineEmptyLocations = [], elevenEmptyLocations = [], oneEmptyLocations = [], twoEmptyLocations = [], fourEmptyLocations = [], sixEmptyLocations = [];
let nineFilledLocations = [], elevenFilledLocations = [], oneFilledLocations = [], twoFilledLocations = [], fourFilledLocations = [], sixFilledLocations = [];

let leaveFirstHourInput = document.getElementById('leaveFirstHour');
let leaveSecondHourInput = document.getElementById('leaveSecondHour');
let leaveInitialsInput = document.getElementById('leaveInitials');
let leaveAdd = document.getElementById('leaveAdd');

let programFirstHourInput = document.getElementById('programFirstHour');
let programSecondHourInput = document.getElementById('programSecondHour');
let programInitialsInput = document.getElementById('programInitials');
let programAdd = document.getElementById('programAdd');

let meetingsFirstHourInput = document.getElementById('meetingsFirstHour');
let meetingsSecondHourInput = document.getElementById('meetingsSecondHour');
let meetingsInitialsInput = document.getElementById('meetingsInitials');
let meetingsAdd = document.getElementById('meetingsAdd');

let meetingTimes = [nineMeetings, elevenMeetings, oneMeetings, twoMeetings, fourMeetings, sixMeetings];
let programTimes = [ninePrograms, elevenPrograms, onePrograms, twoPrograms, fourPrograms, sixPrograms];
let projectTimes = [nineProject, elevenProject, oneProject, twoProject, fourProject, sixProject];
let leaveTimes = [nineLeave, elevenLeave, oneLeave, twoLeave, fourLeave, sixLeave];

let leaveLoggedHoursInitials = [];
let leaveLoggedInitials = [];
let leaveLoggedCombined = [];

let meetingsLoggedHoursInitials = [];
let meetingsLoggedCombined = [];

let programsLoggedHoursInitials = [];
let programsLoggedInitials = [];
let programsLoggedCombined = [];
let programsNames = [];

let leaveLogged = document.getElementById('leaveLogged');
let programsLogged = document.getElementById('programsLogged');
let meetingsLogged = document.getElementById('meetingsLogged');

let hourTimes = [9, 11, 13, 14, 16, 18];
let meetingIndex = [0, 1, 2, 3, 4, 5];
let loggedLocTemp = '';
let tempArrayCompare = [];
let tempLogged = [];

let stringToLog;
let currentFree = [];

meetingsInitialsInput.addEventListener("keypress", function(event) {
    if (event.key === "Enter") {
        event.preventDefault();
        meetingsAdd.click();
    }
});

programInitialsInput.addEventListener("keypress", function(event) {
    if (event.key === "Enter") {
        event.preventDefault();
        programAdd.click();
    }
});

leaveInitialsInput.addEventListener("keypress", function(event) {
    if (event.key === "Enter") {
        event.preventDefault();
        leaveAdd.click();
    }
});

window.onload = fillHours();

function fillHours () {
    if(document.getElementById('date').innerHTML.includes('Tuesday')) {
        [ninePUW[0].innerHTML, elevenPUW[0].innerHTML, onePUW[0].innerHTML, twoPUW[0].innerHTML, fourPUW[0].innerHTML, sixPUW[0].innerHTML] = [steve[0], tyler[0], anthony[0], lea[0] + ' \'til 3:30<br>' + cheryl[0] + ' at 3:30', raef[0] + ' \'til 5<br>' + gwen[0] + ' at 5', cheryl[0]];
        [nineFL[0].innerHTML, elevenFL[0].innerHTML, oneFL[0].innerHTML, twoFL[0].innerHTML, fourFL[0].innerHTML, sixFL[0].innerHTML] = [tyler[0], lindsey[0], '', steve[0], jess[0] + ' \'til 5:30', keith[0]];
        [nineSP1a[0].innerHTML, elevenSP1a[0].innerHTML, oneSP1a[0].innerHTML, twoSP1a[0].innerHTML, fourSP1a[0].innerHTML, sixSP1a[0].innerHTML] = [yami[0], jess[0], steve[0], raef[0], cheryl[0], wendy[0]];
        [nineSP1b[0].innerHTML, elevenSP1b[0].innerHTML, oneSP1b[0].innerHTML, twoSP1b[0].innerHTML, fourSP1b[0].innerHTML, sixSP1b[0].innerHTML] = [lindsey[0], shaquiella[0], chris[0], tyler[0], deborah[0] + ' at 4:30', deborah[0]];
        [nineSP2a[0].innerHTML, elevenSP2a[0].innerHTML, oneSP2a[0].innerHTML, twoSP2a[0].innerHTML, fourSP2a[0].innerHTML, sixSP2a[0].innerHTML] = [chris[0], anthony[0], rod[0], john[0], wendy[0], gwen[0]];
        [nineSP2b[0].innerHTML, elevenSP2b[0].innerHTML, oneSP2b[0].innerHTML, twoSP2b[0].innerHTML, fourSP2b[0].innerHTML, sixSP2b[0].innerHTML] = [jess[0], sonaite[0], shaquiella[0], lindsey[0], steve[0] + ' \'til 5:30', ''];
        [nineProject[0].innerHTML, elevenProject[0].innerHTML, oneProject[0].innerHTML, twoProject[0].innerHTML, fourProject[0].innerHTML, sixProject[0].innerHTML] = [michelle[1] + ', ' + rod[1] + ', ' + sonaite[1] + ', ' + shaquiella[1], michelle[1] + ', ' + rod[1] + ', ' + yami[1] + ', ' + chris[1] + ', ' + steve[1] + ' \'til 12', yami[1], michelle[1] + ', ' + rod[1] + ', ' + anthony[1] + ', ' + jess[1] + ', ' + sonaite[1] + ' \'til 4:45', lea[1] + ', ' + john[1] + ', ' + sonaite[1] + ' \'til 5' + ', ' + michelle[1] + ', ' + rod[1] + ', ' + yami[1] + ', ' + steve[1] + ', ' + chris[1] + ', ' + tyler[1] + ', ' + lindsey[1] + ' \'til 5:30', lea[1] + ', ' + john[1] + ', ' + raef[1]];
        [michelle[3], michelle[4]] = [9, 17.5];
        [rod[3], rod[4], rod[5], rod[6]] = [9, 17.5, 12, 1];
        [yami[3], yami[4], yami[5], yami[6]] = [9, 17.5, 12, 1];
        [steve[3], steve[4], steve[5], steve[6]] = [9, 17.5, 12, 1];
        [jess[3], jess[4], jess[5], jess[6]] = [9, 17.5, 13, 1];
        [lindsey[3], lindsey[4], lindsey[5], lindsey[6]] = [9, 17.5, 13, 1];
        [chris[3], chris[4], chris[5], chris[6]] = [9, 17.5, 12, 1];
        [tyler[3], tyler[4], tyler[5], tyler[6]] = [9, 17.5, 13, 1];
        [shaquiella[3], shaquiella[4], shaquiella[5], shaquiella[6]] = [9, 17.5];
        [sonaite[3], sonaite[4], sonaite[5], sonaite[6]] = [8.5, 17.5, 13, 1];
        [anthony[3], anthony[4], anthony[5], anthony[6]] = [11, 16];
        [lea[3], lea[4], lea[5], lea[6]] = [14, 20, 16.5, .5];
        [john[3], john[4], john[5], john[6]] = [14, 20, 17, .5];
        [raef[3], raef[4], raef[5], raef[6]] = [14, 20, 17.5, .5];
        [cheryl[3], cheryl[4]] = [15.5, 20];
        [wendy[3], wendy[4]] = [16, 20];
        [deborah[3], deborah[4]] = [16.5, 20];
        [gwen[3], gwen[4]] = [17, 20];
        [keith[3], keith[4]] = [11, 19, 16.5, 1];
        workersLogged('9', '17.5');
        workersLogged('8.5', '17.5');
        workersLogged('11', '16');
        workersLogged('14', '20');
        document.getElementById('full-time-workers').innerHTML = stringToLog;
        stringToLog = '';
        workersLogged('15.5', '20');
        workersLogged('16', '20');
        workersLogged('16.5', '20');
        workersLogged('17', '20');
        document.getElementById('part-time-workers').innerHTML = '<b>12-3:</b> Jerry</br><b>2-5:15:</b> Judy</br>' + stringToLog;
        stringToLog = '';
        document.getElementById('security-workers').innerHTML = '<b>9-1:</b> Christa</br><b>11-7:</b> Keith</br><b>5:15-7:</b> Keith';
        lunchLogged('12', '1');
        lunchLogged('13', '1');
        lunchLogged('16.5', '1');
        lunchLogged('16.5', '.5');
        lunchLogged('17', '.5');
        lunchLogged('17.5', '.5');
        document.getElementById('lunch-breaks').innerHTML = stringToLog;
        stringToLog = '';
        for(i=0;i<locations.length;i++) {
            locations[i][0].innerHTML = locations[i][0].innerHTML.replace(/SK/g, 'SDK');
        }
    }
}

function lunchLogged(firstHour, breakLength) {
    let convertedFirstHour;
    let converterIndex = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8];
    let originalIndex = [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
    let originalMinuteIndex = ['.25', '.5', '.75'];
    let converterMinuteIndex = [':15', ':30', ':45'];
    let firstHourDividingPoint = firstHour.indexOf('.');
    let employeesToLog = [];
    let hourBreak = Number(firstHour) + 1;
    let halfBreak = Number(firstHour) + .5;
    hourBreak = hourBreak.toString();
    halfBreak = halfBreak.toString();
    let hourBreakDividingPoint = hourBreak.indexOf('.');
    let halfBreakDividingPoint = halfBreak.indexOf('.');

    if(firstHourDividingPoint != -1) {
        for(i=0;i<originalIndex.length;i++) {
            for(j=0;j<originalMinuteIndex.length;j++) {
                if(firstHour.slice(0, firstHourDividingPoint) == originalIndex[i] && firstHour.slice(firstHourDividingPoint) == originalMinuteIndex[j]) {
                    convertedFirstHour = converterIndex[i] + converterMinuteIndex[j];
                }
            }
        }
    } else {
        for(i=0;i<originalIndex.length;i++) {
            if(firstHour == originalIndex[i]) {
                convertedFirstHour = converterIndex[i];
            }
        }
    }
    if(hourBreakDividingPoint != -1) {
        for(i=0;i<originalIndex.length;i++) {
            for(j=0;j<originalMinuteIndex.length;j++) {
                if(hourBreak.slice(0, hourBreakDividingPoint) == originalIndex[i] && hourBreak.slice(hourBreakDividingPoint) == originalMinuteIndex[j]) {
                    hourBreak = converterIndex[i] + converterMinuteIndex[j];
                }
            }
        }
    } else {
        for(i=0;i<originalIndex.length;i++) {
            if(hourBreak == originalIndex[i]) {
                hourBreak = converterIndex[i];
            }
        }
    }
    if(halfBreakDividingPoint != -1) {
        for(i=0;i<originalIndex.length;i++) {
            for(j=0;j<originalMinuteIndex.length;j++) {
                if(halfBreak.slice(0, halfBreakDividingPoint) == originalIndex[i] && halfBreak.slice(halfBreakDividingPoint) == originalMinuteIndex[j]) {
                    halfBreak = converterIndex[i] + converterMinuteIndex[j];
                }
            }
        }
    } else {
        for(i=0;i<originalIndex.length;i++) {
            if(halfBreak == originalIndex[i]) {
                halfBreak = converterIndex[i];
            }
        }
    }
    for(i=0;i<employee.length;i++) {
        if(employee[i][5] == firstHour) {
            employeesToLog.push(employee[i][1]);
        }
    }
    initialsCleaner(employeesToLog);
    for(i=0;i<employeesToLog.length;i++) {
        for(j=0;j<employee.length;j++) {
            if(employeesToLog[i] == employee[j][1]) {
                employeesToLog[i] = employee[j][0];
            }
        }
    }
    if(stringToLog == '' || stringToLog == undefined) {
        for(i=0;i<originalIndex.length;i++) {
            if(hourBreak == originalIndex[i]) {
                hourBreak = converterIndex[i];
            }
        }
        if(breakLength == 1) {
            stringToLog = '<b>' + convertedFirstHour + '-' + hourBreak + ':</b> ' + employeesToLog.join(', ');
        } else {
            stringToLog = '<b>' + convertedFirstHour + '-' + halfBreak + ':</b> ' + employeesToLog.join(', ');
        }
    } else {
        if(breakLength == 1) {
            stringToLog = stringToLog + '</br><b>' + convertedFirstHour + '-' + hourBreak + ':</b> ' + employeesToLog.join(', ');
        } else {
            stringToLog = stringToLog + '</br><b>' + convertedFirstHour + '-' + halfBreak + ':</b> ' + employeesToLog.join(', ');
        }
    }
}

function workersLogged(firstHour, secondHour) {
    let convertedFirstHour;
    let convertedSecondHour;
    let converterIndex = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8];
    let originalIndex = [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
    let originalMinuteIndex = ['.25', '.5', '.75'];
    let converterMinuteIndex = [':15', ':30', ':45'];
    let firstHourDividingPoint = firstHour.indexOf('.');
    let secondHourDividingPoint = secondHour.indexOf('.');
    let employeesToLog = [];

    if(firstHourDividingPoint != -1) {
        for(i=0;i<originalIndex.length;i++) {
            for(j=0;j<originalMinuteIndex.length;j++) {
                if(firstHour.slice(0, firstHourDividingPoint) == originalIndex[i] && firstHour.slice(firstHourDividingPoint) == originalMinuteIndex[j]) {
                    convertedFirstHour = converterIndex[i] + converterMinuteIndex[j];
                }
            }
        }
    } else {
        for(i=0;i<originalIndex.length;i++) {
            if(firstHour == originalIndex[i]) {
                convertedFirstHour = converterIndex[i];
            }
        }
    }
    if(secondHourDividingPoint != -1) {
        for(i=0;i<originalIndex.length;i++) {
            for(j=0;j<originalMinuteIndex.length;j++) {
                if(secondHour.slice(0, secondHourDividingPoint) == originalIndex[i] && secondHour.slice(secondHourDividingPoint) == originalMinuteIndex[j]) {
                    convertedSecondHour = converterIndex[i] + converterMinuteIndex[j];
                }
            }
        }
    } else {
        for(i=0;i<originalIndex.length;i++) {
            if(secondHour == originalIndex[i]) {
                convertedSecondHour = converterIndex[i];
            }
        }
    }
    for(i=0;i<employee.length;i++) {
        if(employee[i][3] == firstHour && employee[i][4] == secondHour) {
            employeesToLog.push(employee[i][1]);
        }
    }
    initialsCleaner(employeesToLog);
    for(i=0;i<employeesToLog.length;i++) {
        for(j=0;j<employee.length;j++) {
            if(employeesToLog[i] == employee[j][1]) {
                employeesToLog[i] = employee[j][0];
            }
        }
    }
    if(stringToLog == '' || stringToLog == undefined) {
        stringToLog = '<b>' + convertedFirstHour + '-' + convertedSecondHour + ':</b> ' + employeesToLog.join(', ');
    } else {
        stringToLog = stringToLog + '</br><b>' + convertedFirstHour + '-' + convertedSecondHour + ':</b> ' + employeesToLog.join(', ');
    }
}

function initialsCleaner(loggedLoc) {
    for(i=0;i<loggedLoc.length;i++) {
        for(j=0;j<employee.length;j++) {
            if(loggedLoc[i] == employee[j][1]) {
                loggedLoc[i] = employee[j][2] + employee[j][1];
            }
        }
    }
    loggedLoc.sort();
    for(i=0;i<loggedLoc.length;i++) {
        loggedLoc[i] = loggedLoc[i].substring(1);
    }
}

function meetingProgramLogger(logged, location) {
    let firstHourConv = '';
    let secondHourConv = '';
    let firstHourTime = '';
    let secondHourTime = '';
    let hourConvBefore = [1, 2, 3, 4, 5, 6, 7, 8];
    let hourConvAfter = [13, 14, 15, 16, 17, 18, 19, 20];
    
    let initialsTemp = [];
    let timeIndex = [];

    let dividingPoint = '';

    for(i=0;i<logged.length;i++) {
        if(logged[i].includes('-')) {
            timeIndex.push(i);
        }
    }
    for(i=0;i<hourTimes.length;i++) {
        for(j=0;j<timeIndex.length;j++) {
            dividingPoint = logged[timeIndex[j]].indexOf('-');
            firstHourConv = logged[timeIndex[j]].slice(0, dividingPoint);
            secondHourConv = logged[timeIndex[j]].slice(dividingPoint +1);
            firstHourTime = logged[timeIndex[j]].slice(0, dividingPoint);
            secondHourTime = logged[timeIndex[j]].slice(dividingPoint +1);
            firstHourTime = firstHourTime.replace(/\.5/g, ':30');
            secondHourTime = secondHourTime.replace(/\.5/g, ':30');
            firstHourComp = '';
            secondHourComp = '';
        }
        for(j=0;j<hourConvBefore.length;j++) {
            if(firstHourConv == hourConvBefore[j]) {
                firstHourConv = hourConvAfter[j];
            } else
            if(firstHourConv == hourConvBefore[j] + .5) {
                firstHourConv = hourConvAfter[j] + .5;
            }
            if(secondHourConv == hourConvBefore[j]) {
                secondHourConv = hourConvAfter[j];
            } else
            if(secondHourConv == hourConvBefore[j] + .5) {
                secondHourConv = hourConvAfter[j] + .5;
            }
        }
    }
    for(i=0;i<hourTimes.length;i++) {
        //FIRST HOUR
        if(firstHourConv >= hourTimes[i] && firstHourConv < hourTimes[i+1] && firstHourConv < 20 || firstHourConv >= hourTimes[i] && hourTimes[i+1] ==undefined) {
            for(j=0;j<timeIndex.length;j++) {
                firstHourComp = logged[timeIndex[j]].slice(0, dividingPoint);
                for(k=0;k<hourConvBefore.length;k++) {
                    if(firstHourComp == hourConvBefore[k]) {
                        firstHourComp = hourConvAfter[k];
                    } else
                    if(firstHourComp == hourConvBefore[k] + .5) {
                        firstHourComp = hourConvAfter[k] + .5;
                    }
                }
                if(firstHourConv == firstHourComp) {
                    if(timeIndex.length == 1) {
                        initialsTemp = [];
                        for(k=j+1;k<logged.length;k++) {
                            if(!logged[k].includes('*')) {
                                initialsTemp.push(logged[k]);
                            }
                        }
                        if(location[i][0].innerHTML == '' || location[i][0].innerHTML == undefined) {
                            if(firstHourConv == hourTimes[i]) {
                                location[i][0].innerHTML = initialsTemp.join(', ');
                                break;
                            } else {
                                location[i][0].innerHTML = initialsTemp.join(', ') + ' at ' + firstHourTime;
                                break;
                            }
                        } else {
                            if(firstHourConv == hourTimes[i]) {
                                location[i][0].innerHTML = location[i][0].innerHTML + ', ' + initialsTemp.join(', ');
                                break;
                            } else {
                                location[i][0].innerHTML = location[i][0].innerHTML + ', ' + initialsTemp.join(', ') + ' at ' + firstHourTime;
                                break;
                            }
                        }
                    } else
                    if(j > 0 && j != timeIndex.length-1) {
                        initialsTemp = [];
                        for(k=timeIndex[timeIndex.length-1]+1;k<logged.length;k++) {
                            if(!logged[k].includes('*')) {
                                initialsTemp.push(logged[k]);
                            }
                        }
                        if(location[i][0].innerHTML == '' || location[i][0].innerHTML == undefined) {
                            if(firstHourConv == hourTimes[i]) {
                                location[i][0].innerHTML = initialsTemp.join(', ');
                                break;
                            } else {
                                location[i][0].innerHTML = initialsTemp.join(', ') + ' at ' + firstHourTime;
                                break;
                            }
                        } else {
                            if(firstHourConv == hourTimes[i]) {
                                location[i][0].innerHTML = location[i][0].innerHTML + ', ' + initialsTemp.join(', ');
                                break;
                            } else {
                                location[i][0].innerHTML = location[i][0].innerHTML + ', ' + initialsTemp.join(', ') + ' at ' + firstHourTime;
                                break;
                            }
                        }
                    } else
                    if(j == timeIndex.length-1) {
                        initialsTemp = [];
                        for(k=timeIndex[timeIndex.length-1]+1;k<logged.length;k++) {
                            if(!logged[k].includes('*')) {
                                initialsTemp.push(logged[k]);
                            }
                        }
                        if(location[i][0].innerHTML == '' || location[i][0].innerHTML == undefined) {
                            if(firstHourConv == hourTimes[i]) {
                                location[i][0].innerHTML = initialsTemp.join(', ');
                                break;
                            } else {
                                location[i][0].innerHTML = initialsTemp.join(', ') + ' at ' + firstHourTime;
                                break;
                            }
                        } else {
                            if(firstHourConv == hourTimes[i]) {
                                location[i][0].innerHTML = location[i][0].innerHTML + ', ' + initialsTemp.join(', ');
                                break;
                            } else {
                                location[i][0].innerHTML = location[i][0].innerHTML + ', ' + initialsTemp.join(', ') + ' at ' + firstHourTime;
                                break;
                            }
                        }
                    }
                }
            }
        }
        //MIDDLE SECTIONS
        if(firstHourConv < hourTimes[i] && secondHourConv > hourTimes[i] && secondHourConv > hourTimes[i+1]) {
            if(location[i][0].innerHTML == '' || location[i][0].innerHTML == undefined) {
                location[i][0].innerHTML = initialsTemp.join(', ');
            } else {
                location[i][0].innerHTML = location[i][0].innerHTML + ', ' + initialsTemp.join(', ');
            }
        }
        //SECOND HOUR
        if(secondHourConv > hourTimes[i] && secondHourConv <= hourTimes[i+1] && firstHourConv < hourTimes[i] ||secondHourConv >= hourTimes[i] && hourTimes[i+1] == undefined && firstHourConv < hourTimes[i]) {
            for(j=0;j<timeIndex.length;j++) {
                secondHourComp = logged[timeIndex[j]].slice(dividingPoint + 1);
                for(k=0;k<hourConvBefore.length;k++) {
                    if(secondHourComp == hourConvBefore[k]) {
                        secondHourComp = hourConvAfter[k];
                    } else
                    if(secondHourComp == hourConvBefore[k] + .5) {
                        secondHourComp = hourConvAfter[k] + .5;
                    }
                }
                if(secondHourConv == secondHourComp) {

                    if(timeIndex.length == 1) {
                        initialsTemp = [];
                        for(k=j+1;k<logged.length;k++) {
                            if(!logged[k].includes('*')) {
                                initialsTemp.push(logged[k]);
                            }
                        }
                        if(location[i][0].innerHTML == '' || location[i][0].innerHTML == undefined) {
                            if(secondHourConv == hourTimes[i] || secondHourConv == 20 || secondHourConv == hourTimes[i+1]) {
                                location[i][0].innerHTML = initialsTemp.join(', ');
                                break;
                            } else {
                                location[i][0].innerHTML = initialsTemp.join(', ') + ' \'til ' + secondHourTime;
                                break;
                            }
                        } else {
                            if(secondHourConv == hourTimes[i] || secondHourConv == 20 || secondHourConv == hourTimes[i+1]) {
                                location[i][0].innerHTML = location[i][0].innerHTML + ', ' + initialsTemp.join(', ');
                                break;
                            } else {
                                location[i][0].innerHTML = location[i][0].innerHTML + ', ' + initialsTemp.join(', ') + ' \'til ' + secondHourTime;
                                break;
                            }
                        }
                    }
                } else 
                    if(j != timeIndex.length-1) {

                        initialsTemp = [];
                        for(k=timeIndex[timeIndex.length-1]+1;k<logged.length;k++) {
                            if(!logged[k].includes('*')) {
                                initialsTemp.push(logged[k]);
                            }
                        }
                        if(location[i][0].innerHTML == '' || location[i][0].innerHTML == undefined) {
                            if(secondHourConv == hourTimes[i] || secondHourConv == 20) {
                                location[i][0].innerHTML = initialsTemp.join(', ');
                                break;
                            } else {
                                location[i][0].innerHTML = initialsTemp.join(', ') + ' \'til ' + secondHourTime;
                                break;
                            }
                        } else {
                            if(secondHourConv == hourTimes[i] || secondHourConv == 20) {
                                location[i][0].innerHTML = location[i][0].innerHTML + ' , ' + initialsTemp.join(', ');
                                break;
                            } else {
                                location[i][0].innerHTML = location[i][0].innerHTML + ', ' + initialsTemp.join(', ') + ' \'til ' + secondHourTime;
                                break;
                            }
                        }
                    } else
                    if(j == timeIndex.length-1) {
                        initialsTemp = [];
                        for(k=timeIndex[timeIndex.length-1]+1;k<logged.length;k++) {
                            if(!logged[k].includes('*')) {
                                initialsTemp.push(logged[k]);
                            }
                        }
                        if(location[i][0].innerHTML == '' || location[i][0].innerHTML == undefined) {
                            if(secondHourConv == hourTimes[i] || secondHourConv == 20) {
                                location[i][0].innerHTML = initialsTemp.join(', ');
                                break;
                            } else {
                                location[i][0].innerHTML = initialsTemp.join(', ') + ' at ' + secondHourTime;
                                break;
                            }
                        } else {
                            if(secondHourConv == hourTimes[i] || secondHourConv == 20) {
                                location[i][0].innerHTML = location[i][0].innerHTML + ', ' + initialsTemp.join(', ');
                                break;
                            } else {
                                location[i][0].innerHTML = location[i][0].innerHTML + ', ' + initialsTemp.join(', ') + ' at ' + secondHourTime;
                                break;
                        }
                    }
                }
            }
        }
    }

    initialsTemp = [];
    firstHourConv = '';
    secondHourConv = '';
    firstHourTime = '';
    secondHourTime = '';
}

function removeFromLoc(busyLocTimes, time, workLocTimes, ignoreIndex) {
    for(i=0;i<busyLocTimes.length;i++) {
        busyLocTimes[i][0].innerHTML = busyLocTimes[i][0].innerHTML.replace(/SDK/g, 'SK');
    }
    let commaIndex = [];
    for(i=0;i<busyLocTimes[time][0].innerHTML.length;i++) {
        if(busyLocTimes[time][0].innerHTML.charAt(i) == ',') {
            commaIndex.push(i);
        }
    }
    for(i=0;i<workLocTimes.length;i++) {
        for(j=0;j<employee.length;j++) {
            if(busyLocTimes[time][0].innerHTML.includes(employee[j][1]) && i != ignoreIndex) {
                for(k=0;k<2;k++) {
                    if(workLocTimes[i][0].innerHTML.includes(', ' + employee[j][k])) {
                        workLocTimes[i][0].innerHTML = workLocTimes[i][0].innerHTML.replace(', ' + employee[j][k], '');
                        workLocTimes[i][2] = '';
                    } else
                    if(workLocTimes[i][0].innerHTML.includes(', ' + employee[j][k] + ',')) {
                        workLocTimes[i][0].innerHTML = workLocTimes[i][0].innerHTML.replace(', ' + employee[j][k] + ',', '');
                        workLocTimes[i][2] = '';
                    } else
                    if(workLocTimes[i][0].innerHTML.includes(employee[j][k] + ', ')) {
                        workLocTimes[i][0].innerHTML = workLocTimes[i][0].innerHTML.replace(employee[j][k] + ', ', '');
                        workLocTimes[i][2] = '';
                    } else
                    if(workLocTimes[i][0].innerHTML.includes(employee[j][k])) {
                        workLocTimes[i][0].innerHTML = workLocTimes[i][0].innerHTML.replace(employee[j][k], '');
                        workLocTimes[i][2] = '';
                    } else
                    if(workLocTimes[i][0].innerHTML.includes(', SDK') && employee[j][1] == 'SK') {
                        workLocTimes[i][0].innerHTML = workLocTimes[i][0].innerHTML.replace(', SDK', '');
                    } else
                    if(workLocTimes[i][0].innerHTML.includes(', SDK ,') && employee[j][1] == 'SK') {
                        workLocTimes[i][0].innerHTML = workLocTimes[i][0].innerHTML.replace(', SDK ,', '');
                    } else
                    if(workLocTimes[i][0].innerHTML.includes('SDK, ') && employee[j][1] == 'SK') {
                        workLocTimes[i][0].innerHTML = workLocTimes[i][0].innerHTML.replace('SDK, ', '');
                    } else
                    if(workLocTimes[i][0].innerHTML.includes('SDK') && employee[j][1] == 'SK') {
                        workLocTimes[i][0].innerHTML = workLocTimes[i][0].innerHTML.replace('SDK', '');
                    }
                }
            }
        }
    }
    for(i=0;i<busyLocTimes.length;i++) {
        busyLocTimes[i][0].innerHTML = busyLocTimes[i][0].innerHTML.replace(/SK/g, 'SDK');
    }
}

function htmlToLog(timeLocIndex) {
    if(timeLocations[timeLocIndex][8][0].innerHTML != '') {
        currentFree = [];
        let sepIndex = [];
        if(!timeLocations[timeLocIndex][8][0].innerHTML.includes(',')) {
            currentFree.push(timeLocations[timeLocIndex][8][0].innerHTML);
        } else {
            for(m=0;m<timeLocations[timeLocIndex][8][0].innerHTML.length;m++) {
                if(timeLocations[timeLocIndex][8][0].innerHTML.charAt(m) == ',')
                sepIndex.push(m);
            }
            for(m=0;m<sepIndex.length;m++) {
                if(m == 0) {
                    currentFree.push(timeLocations[timeLocIndex][8][0].innerHTML.slice(0, sepIndex[m]));
                    currentFree.push(timeLocations[timeLocIndex][8][0].innerHTML.slice(sepIndex[m]+2, sepIndex[m+1]));
                } else
                if(m != sepIndex.length && m != 0) {
                    currentFree.push(timeLocations[timeLocIndex][8][0].innerHTML.slice(sepIndex[m]+2, sepIndex[m+1]));
                } else
                if(m == sepIndex.length) {
                    currentFree.push(timeLocations[timeLocIndex][8][0].innerHTML.slice(sepIndex[m]+2));
                }
            } 
        }
    }
}

function compareForEmptyLoc(timeLocation, timeLocationEmpty, timeSP2b, timeSP2a, timeSP1b, timeSP1a, numTime) {
    let compareArray = [];
    let currentFreeInit = [];
    currentFree = [];
    for(i=0;i<6;i++) {
        if(timeLocation[i][0].innerHTML == '') {
            compareArray.push(timeLocation[i][1]);
        }
    }
    if(compareArray.includes(timeSP1a) && !compareArray.includes(timeSP1b)) {
        document.getElementById(timeSP1a).innerHTML = document.getElementById(timeSP1b).innerHTML;
        document.getElementById(timeSP1b).innerHTML = '';
        compareArray.splice(compareArray.indexOf(timeSP1a), 1);
    }
    if(compareArray.includes(timeSP2a) && !compareArray.includes(timeSP2b)) {
        document.getElementById(timeSP2a).innerHTML = document.getElementById(timeSP2b).innerHTML;
        document.getElementById(timeSP2b).innerHTML = '';
        compareArray.splice(compareArray.indexOf(timeSP2a), 1);
    }
    if(compareArray.includes(timeSP2b) && !compareArray.includes(timeSP2a)) {
        delIndex = compareArray.indexOf(timeSP2b);
        compareArray.splice(delIndex, 1);
    }
    if(compareArray.includes(timeSP1b) && !compareArray.includes(timeSP1a)) {
        delIndex = compareArray.indexOf(timeSP1b);
        compareArray.splice(delIndex, 1);
    }
    htmlToLog(numTime);
    for(i=0;i<currentFree.length;i++) {
        currentFree[i] = currentFree[i].replace(/SDK/g, 'SK');
    }
    initialsCleaner(currentFree);
    currentFree.reverse();
    timeLocationEmpty = [];
    timeLocationEmpty = compareArray;
    for(i=0;i<currentFree.length;i++) {
        for(j=0;j<employee.length;j++) {
            if(currentFree[i] == employee[j][1]) {
                currentFree[i] = employee[j][0];
                currentFreeInit.push(employee[j][1]);
            }
        }
    }
    for(i=0;i<timeLocationEmpty.length;i++) {
        document.getElementById(timeLocationEmpty[i]).innerHTML = currentFree[0];
        currentFree.splice(0, 1);
        currentFreeInit.splice(0, 1);
        timeLocationEmpty.splice(i, 1);
    }
    currentFreeInit.reverse();
    for(i=0;i<currentFreeInit.length;i++) {
        currentFreeInit[i] = currentFreeInit[i].replace(/SK/g, 'SDK');
    }
    timeLocation[8][0].innerHTML = currentFreeInit.join(', ');
}

function addLeave() {
    if(leaveFirstHourInput.value == '5:30') {
        leaveFirstHourInput.value = 5.5;
    }
    if(leaveSecondHourInput.value == '5:30') {
        leaveSecondHourInput.value = 5.5;
    }
    leaveFirstHourInput.value = leaveFirstHourInput.value.replace(/:30/g, '.5');
    leaveSecondHourInput.value = leaveSecondHourInput.value.replace(/:30/g, '.5');
    leaveInitialsInput.value = leaveInitialsInput.value.replace(/sdk/g, 'SK');
    leaveInitialsInput.value = leaveInitialsInput.value.replace(/SDK/g, 'SK');
    leaveInitialsInput.value = leaveInitialsInput.value.replace(/, /g, '');
    leaveInitialsInput.value = leaveInitialsInput.value.toUpperCase();
    tempInit = leaveInitialsInput.value.match(/.{1,2}/g);
    initialsCleaner(tempInit);

    if(leaveInitialsInput.value != '' && leaveFirstHourInput.value != '' || leaveSecondHourInput.value != '') {
        leaveLoggedHoursInitials.push(leaveFirstHourInput.value + '-' + leaveSecondHourInput.value);
        leaveLoggedHoursInitials = leaveLoggedHoursInitials.concat(tempInit);
    } else
    if(leaveInitialsInput.value != '' && leaveFirstHourInput.value == '' || leaveSecondHourInput.value == '') {
        leaveLoggedHoursInitials.push('9-8');
        leaveLoggedHoursInitials = leaveLoggedHoursInitials.concat(tempInit);
    }

    leaveFirstHourInput.value = '';
    leaveSecondHourInput.value = '';
    leaveInitialsInput.value = '';

    let firstHour;
    let secondHour;
    let dividingPoint;
    let tempString;
    let tempStore = [];

    for(i=0;i<leaveLoggedHoursInitials.length;i++) {
        if(leaveLoggedHoursInitials[i].includes('-')) {
            if(leaveLoggedHoursInitials[i] == '9-8') {
                if(tempString == '' || tempString == undefined) {
                    tempString = '';
                } else {
                    tempString = tempString + '<br>';
                }
            } else {
                if(tempString == '' || tempString == undefined) {
                    tempString = '<b>' + leaveLoggedHoursInitials[i] + ': </b>';
                } else {
                    tempString = tempString + '<br><b>' + leaveLoggedHoursInitials[i] + ': </b>';
                }
            }
        } else 
        if(!leaveLoggedHoursInitials[i].includes('-') && i != leaveLoggedHoursInitials.length-1) {
            tempString = tempString + leaveLoggedHoursInitials[i] + ', ';
        } else 
        if(!leaveLoggedHoursInitials[i].includes('-') && i == leaveLoggedHoursInitials.length-1) {
            tempString = tempString + leaveLoggedHoursInitials[i];
        }
    }

    tempString = tempString.replace(/\.5/g, ':30');
    tempString = tempString.replace(/, <br>/g, '<br>');
    leaveLogged.innerHTML = tempString;
    leaveLogged.innerHTML = leaveLogged.innerHTML.replace(/SK/, 'SDK');

    let hoursTempIndex = [];
    for(i=0;i<leaveLoggedHoursInitials.length;i++) {
        if(leaveLoggedHoursInitials[i].includes('-')) {
            hoursTempIndex.push(i);
        }
    }
    meetingProgramLogger(leaveLoggedHoursInitials, leaveTimes);
    removeFromLoc(leaveTimes, 0, nineLocations, );
    removeFromLoc(leaveTimes, 1, elevenLocations);
    removeFromLoc(leaveTimes, 2, oneLocations);
    removeFromLoc(leaveTimes, 3, twoLocations);
    removeFromLoc(leaveTimes, 4, fourLocations);
    removeFromLoc(leaveTimes, 5, sixLocations);
    for(i=0;i<meetingTimes.length;i++) {
        meetingTimes[i][0].innerHTML = meetingTimes[i][0].innerHTML.replace(/SK/g, 'SDK');
    }
}

function addMeeting() {
    if(meetingsFirstHourInput.value == '5:30') {
        meetingsFirstHourInput.value = 5.5;
    }
    if(meetingsSecondHourInput.value == '5:30') {
        meetingsSecondHourInput.value = 5.5;
    }
    meetingsFirstHourInput.value = meetingsFirstHourInput.value.replace(/:30/g, '.5');
    meetingsSecondHourInput.value = meetingsSecondHourInput.value.replace(/:30/g, '.5');
    meetingsInitialsInput.value = meetingsInitialsInput.value.replace(/sdk/g, 'SK');
    meetingsInitialsInput.value = meetingsInitialsInput.value.replace(/SDK/g, 'SK');
    meetingsInitialsInput.value = meetingsInitialsInput.value.replace(/, /g, '');
    meetingsInitialsInput.value = meetingsInitialsInput.value.toUpperCase();
    tempInit = meetingsInitialsInput.value.match(/.{1,2}/g);
    initialsCleaner(tempInit);
    let tempNames = []
    let meetingsLoggedHoursNames = [];

    for(i=0;i<tempInit.length;i++) {
        for(j=0;j<employee.length;j++) {
            if(tempInit[i] == employee[j][1]) {
                tempNames.push(employee[j][0]);
            }
        }
    }
    if(meetingsInitialsInput.value != '' && meetingsFirstHourInput.value != '' || meetingsSecondHourInput.value != '') {
        meetingsLoggedHoursInitials.push(meetingsFirstHourInput.value + '-' + meetingsSecondHourInput.value);
        meetingsLoggedHoursNames.push(meetingsFirstHourInput.value + '-' + meetingsSecondHourInput.value);
        meetingsLoggedHoursInitials = meetingsLoggedHoursInitials.concat(tempInit);
        meetingsLoggedHoursNames = meetingsLoggedHoursNames.concat(tempNames);
    }

    meetingsFirstHourInput.value = '';
    meetingsSecondHourInput.value = '';
    meetingsInitialsInput.value = '';

    let firstHour;
    let secondHour;
    let dividingPoint;
    let tempString;
    let tempStore = [];

    /*
    for(i=0;i<meetingsLoggedHoursInitials.length;i++) {
        if(meetingsLoggedHoursInitials[i].includes('-')) {
            if(tempString == '' || tempString == undefined) {
                tempString = '<b>' + meetingsLoggedHoursInitials[i] + ': </b>';
            } else {
                tempString = tempString + '<br><b>' + meetingsLoggedHoursInitials[i] + ': </b>';
            }
        } else 
        if(!meetingsLoggedHoursInitials[i].includes('-') && i != meetingsLoggedHoursInitials.length-1) {
            tempString = tempString + meetingsLoggedHoursInitials[i] + ', ';
        } else 
        if (!meetingsLoggedHoursInitials[i].includes('-') && i == meetingsLoggedHoursInitials.length-1) {
            tempString = tempString + meetingsLoggedHoursInitials[i];
        }
    }
    */

    for(i=0;i<meetingsLoggedHoursNames.length;i++) {
        if(meetingsLoggedHoursNames[i].includes('-')) {
            if(tempString == '' || tempString == undefined) {
                tempString = '<b>' + meetingsLoggedHoursNames[i] + ': </b>';
            } else {
                tempString = tempString + '<br><b>' + meetingsLoggedHoursNames[i] + ': </b>';
            }
        } else 
        if(!meetingsLoggedHoursNames[i].includes('-') && i != meetingsLoggedHoursNames.length-1) {
            tempString = tempString + meetingsLoggedHoursNames[i] + ', ';
        } else 
        if (!meetingsLoggedHoursNames[i].includes('-') && i == meetingsLoggedHoursNames.length-1) {
            tempString = tempString + meetingsLoggedHoursNames[i];
        }
    }

    tempString = tempString.replace(/\.5/g, ':30');
    tempString = tempString.replace(/, <br>/g, '<br>');
    meetingsLogged.innerHTML = tempString;
    meetingsLogged.innerHTML = meetingsLogged.innerHTML.replace(/SK/, 'SDK');

    let hoursTempIndex = [];
    for(i=0;i<meetingsLoggedHoursInitials.length;i++) {
        if(meetingsLoggedHoursInitials[i].includes('-')) {
            hoursTempIndex.push(i);
        }
    }
    meetingProgramLogger(meetingsLoggedHoursInitials, meetingTimes);
    removeFromLoc(meetingTimes, 0, nineLocations, 7);
    removeFromLoc(meetingTimes, 1, elevenLocations, 7);
    removeFromLoc(meetingTimes, 2, oneLocations, 7);
    removeFromLoc(meetingTimes, 3, twoLocations, 7);
    removeFromLoc(meetingTimes, 4, fourLocations, 7);
    removeFromLoc(meetingTimes, 5, sixLocations, 7);
    for(i=0;i<meetingTimes.length;i++) {
        meetingTimes[i][0].innerHTML = meetingTimes[i][0].innerHTML.replace(/SK/g, 'SDK');
    }
    compareForEmptyLoc(nineLocations, nineEmptyLocations, 'nineSP2b', 'nineSP2a', 'nineSP1b', 'nineSP1a', 0);
    compareForEmptyLoc(elevenLocations, elevenEmptyLocations, 'elevenSP2b', 'elevenSP2a', 'elevenSP1b', 'elevenSP1a', 1);
    compareForEmptyLoc(oneLocations, oneEmptyLocations, 'oneSP2b', 'oneSP2a', 'oneSP1b', 'oneSP1a', 2);
    compareForEmptyLoc(twoLocations, twoEmptyLocations, 'twoSP2b', 'twoSP2a', 'twoSP1b', 'twoSP1a', 3);
    compareForEmptyLoc(fourLocations, fourEmptyLocations, 'fourSP2b', 'fourSP2a', 'fourSP1b', 'fourSP1a', 4);
    compareForEmptyLoc(sixLocations, sixEmptyLocations, 'sixSP2b', 'sixSP2a', 'sixSP1b', 'sixSP1a', 5);
}

function addProgram() {
    if(programFirstHourInput.value == '5:30') {
        programFirstHourInput.value = 5.5;
    }
    if(programSecondHourInput.value == '5:30') {
        programSecondHourInput.value = 5.5;
    }
    programFirstHourInput.value = programFirstHourInput.value.replace(/:30/g, '.5');
    programSecondHourInput.value = programSecondHourInput.value.replace(/:30/g, '.5');
    programInitialsInput.value = programInitialsInput.value.replace(/sdk/g, 'SK');
    programInitialsInput.value = programInitialsInput.value.replace(/SDK/g, 'SK');
    programInitialsInput.value = programInitialsInput.value.replace(/, /g, '');

    let programInitialsStartIndex = programInitialsInput.value.indexOf('(');
    let programInitialsEndIndex = programInitialsInput.value.indexOf(')');
    let programInitialsStripped = programInitialsInput.value.slice(programInitialsStartIndex + 1, programInitialsEndIndex); 
    let programName = '*' + programInitialsInput.value.slice(0, programInitialsStartIndex-1);
    programName = programName.replace(/-/g, '!');
    programInitialsStripped = programInitialsStripped.toUpperCase();
    tempInit = programInitialsStripped.match(/.{1,2}/g);
    initialsCleaner(tempInit);
    
    if(programInitialsInput.value != '' && programFirstHourInput.value != '' || programSecondHourInput.value != '') {
        programsLoggedHoursInitials.push(programFirstHourInput.value + '-' + programSecondHourInput.value);
        programsLoggedHoursInitials.push(programName);
        programsLoggedHoursInitials = programsLoggedHoursInitials.concat(tempInit);
    }
    
    programFirstHourInput.value = '';
    programSecondHourInput.value = '';
    programInitialsInput.value = '';
    
    let firstHour;
    let secondHour;
    let dividingPoint;
    let tempString;
    let tempStore = [];

    for(i=0;i<programsLoggedHoursInitials.length;i++) {
        if(programsLoggedHoursInitials[i].includes('-')) {
            if(tempString == '' || tempString == undefined) {
                tempString = '<b>' + programsLoggedHoursInitials[i] + ': </b>';
            } else {
                tempString = tempString + '<br><b>' + programsLoggedHoursInitials[i] + ': </b>';
            }
        } else 
        if(!programsLoggedHoursInitials[i].includes('-') && i != programsLoggedHoursInitials.length-1 && !programsLoggedHoursInitials[i].includes('(') && !programsLoggedHoursInitials[i-1].includes('-')) {
            tempString = tempString + programsLoggedHoursInitials[i] + ', ';
        } else 
        if(programsLoggedHoursInitials[i].includes('*')) {
            tempString = tempString + programsLoggedHoursInitials[i].slice(1) + ' (';
        } else
        if (!programsLoggedHoursInitials[i].includes('-') && i == programsLoggedHoursInitials.length-1) {
            tempString = tempString + programsLoggedHoursInitials[i] + ')';
        }
    }

    tempString = tempString.replace(/\.5/g, ':30');
    tempString = tempString.replace(/, <br>/g, '<br>');
    programsLogged.innerHTML = tempString;
    programsLogged.innerHTML = programsLogged.innerHTML.replace(/!/g, '-');
    programsLogged.innerHTML = programsLogged.innerHTML.replace(/<br>/g, ')<br>');
    programsLogged.innerHTML = programsLogged.innerHTML.replace(/SK/, 'SDK');

    let hoursTempIndex = [];
    for(i=0;i<programsLoggedHoursInitials.length;i++) {
        if(programsLoggedHoursInitials[i].includes('-')) {
            hoursTempIndex.push(i);
        }
    }
    meetingProgramLogger(programsLoggedHoursInitials, programTimes);
    removeFromLoc(programTimes, 0, nineLocations, 6);
    removeFromLoc(programTimes, 1, elevenLocations, 6);
    removeFromLoc(programTimes, 2, oneLocations, 6);
    removeFromLoc(programTimes, 3, twoLocations, 6);
    removeFromLoc(programTimes, 4, fourLocations, 6);
    removeFromLoc(programTimes, 5, sixLocations, 6);
    for(i=0;i<meetingTimes.length;i++) {
        meetingTimes[i][0].innerHTML = meetingTimes[i][0].innerHTML.replace(/SK/g, 'SDK');
    }
}

function assignableButton() {
    
}