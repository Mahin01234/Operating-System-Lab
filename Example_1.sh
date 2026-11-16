#!/bin/bash

# Arrays holding the data from the image
pids=("P1" "P2" "P3" "P4" "P5")
arrival=(0 1 2 3 4)
burst=(2 3 5 4 6)
n=${#pids[@]}

current_time=0
total_tat=0
total_wt=0

echo "--------------------------------------------------------------"
printf "%-10s %-10s %-10s %-12s %-12s %-10s\n" "Process" "Arrival" "Burst" "Completion" "Turnaround" "Waiting"
echo "--------------------------------------------------------------"

for (( i=0; i<n; i++ )); do
    # If CPU is idle, jump to the next arrival time
    if [ $current_time -lt ${arrival[$i]} ]; then
        current_time=${arrival[$i]}
    fi

    # Calculations
    ct=$((current_time + burst[$i]))
    tat=$((ct - arrival[$i]))
    wt=$((tat - burst[$i]))

    # Add to totals for average
    total_tat=$((total_tat + tat))
    total_wt=$((total_wt + wt))

    # Print the row
    printf "%-10s %-10s %-10s %-12s %-12s %-10s\n" "${pids[$i]}" "${arrival[$i]}" "${burst[$i]}" "$ct" "$tat" "$wt"

    # Update current time for the next process
    current_time=$ct
done

echo "--------------------------------------------------------------"

# Calculate averages using awk for floating point math
avg_tat=$(echo "scale=2; $total_tat / $n" | bc)
avg_wt=$(echo "scale=2; $total_wt / $n" | bc)

echo ""
echo "Average turnaround time = $total_tat / $n = $avg_tat"
echo "Average waiting time = $total_wt / $n = $avg_wt"

