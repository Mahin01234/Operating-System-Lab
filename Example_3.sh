#!/bin/bash

# Arrays holding the data from Example 3
pids=("P1" "P2" "P3" "P4")
arrival=(0 1 2 3)
burst=(8 4 9 5)
n=${#pids[@]}

current_time=0
total_tat=0
total_wt=0

echo "----------------------------------------------------------------------"
printf "%-10s %-10s %-10s %-12s %-12s %-10s\n" "Process" "Arrival" "Burst" "Completion" "Turnaround" "Waiting"
echo "----------------------------------------------------------------------"

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

echo "----------------------------------------------------------------------"

# Calculate averages and throughput using awk for floating point math
avg_tat=$(awk "BEGIN {printf \"%.2f\", $total_tat / $n}")
avg_wt=$(awk "BEGIN {printf \"%.2f\", $total_wt / $n}")
throughput=$(awk "BEGIN {printf \"%.5f\", $n / $current_time}")

echo ""
echo "Total Wait Time: $total_wt ms"
echo "Average Waiting Time = $total_wt / $n = $avg_wt ms"
echo ""
echo "Total Turn Around Time: $total_tat ms"
echo "Average Turn Around time = $total_tat / $n = $avg_tat ms"
echo ""
echo "Throughput: $n jobs / $current_time sec = $throughput jobs/sec"