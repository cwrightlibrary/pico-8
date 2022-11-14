function compareForEmptyLoc(timeLocation, timeLocationEmpty, timeSP2b, timeSP2a, timeSP1b, timeSP1a) {
    let compareArray = [];
    for(i=0;i<6;i++) {
        if(sixLocations[i][0].innerHTML == '') {
            compareArray.push(sixLocations[i][1]);
        }
    }
    if(compareArray.includes('sixSP2b') && !compareArray.includes('sixSP2a')) {
        delIndex = compareArray.indexOf('sixSP2b');
        compareArray.splice(delIndex, 1);
    }
    if(compareArray.includes('sixSP1b') && !compareArray.includes('sixSP1a')) {
        delIndex = compareArray.indexOf('sixSP1b');
        compareArray.splice(delIndex, 1);
    }
    htmlToLog(5);
    initialsCleaner(currentFree);
    currentFree.reverse();
    sixEmptyLocations = [];
    sixEmptyLocations = compareArray;
    for(i=0;i<currentFree.length;i++) {
        for(j=0;j<employee.length;j++) {
            if(currentFree[i] == employee[j][1]) {
                currentFree[i] = employee[j][0];
            }
        }
    }
    for(i=0;i<sixEmptyLocations.length;i++) {
        document.getElementById(sixEmptyLocations[i]).innerHTML = currentFree[0];
        currentFree.splice(0, 1);
        sixEmptyLocations.splice(i, 1);
    }
}