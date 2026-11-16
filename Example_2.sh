
#!/bin/bash

# FCFS CPU Scheduling

PID=("P1" "P2" "P3")
AT=(0 0 0)
BT=(24 3 3)

n=3
time=0

# Calculate Completion Time
for ((i=0; i<n; i++))
do
    if (( time < AT[i] ))
    then
        time=${AT[i]}
    fi

    time=$((time + BT[i]))
    CT[$i]=$time
done

# Display Gantt Chart
echo "Gantt Chart:"
echo "| P1 | P2 | P3 |"
echo "0    24   27   30"
echo ""

# Display Results
echo "Process   AT   BT   CT   TAT   WT"

totalWT=0
totalTAT=0

for ((i=0; i<n; i++))
do
    TAT=$((CT[i] - AT[i]))
    WT=$((TAT - BT[i]))

    echo "${PID[i]}        ${AT[i]}    ${BT[i]}    ${CT[i]}    $TAT    $WT"

    totalWT=$((totalWT + WT))
    totalTAT=$((totalTAT + TAT))
done

# Calculate Average
avgWT=$(awk "BEGIN {printf \"%.2f\", $totalWT/$n}")
avgTAT=$(awk "BEGIN {printf \"%.2f\", $totalTAT/$n}")

# Calculate Throughput
throughput=$(awk "BEGIN {printf \"%.2f\", $n/$time}")

echo ""
echo "Total Waiting Time = $totalWT ms"
echo "Average Waiting Time = $avgWT ms"

echo ""
echo "Total Turnaround Time = $totalTAT ms"
echo "Average Turnaround Time = $avgTAT ms"

echo ""
echo "Throughput = $throughput jobs per time unit"
