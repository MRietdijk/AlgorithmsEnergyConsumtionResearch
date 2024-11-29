import subprocess
import sys
import pandas as pd

sizes = [10, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500, 8000, 9500, 10000]

for run in range(10):
    energy_data = []
    for item in sizes:
        perf_command = [
            "sudo", "-E", "perf", "stat", "-e",
            "power/energy-pkg/,power/energy-cores/,power/energy-ram/",
            "python3", "{0}.py".format(sys.argv[1]), str(item)
        ]

        process = subprocess.run(perf_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

        perf_output = process.stderr.splitlines()
        total = 0
        seconds = 0
        for line in perf_output:
            if "Joules" in line:
                parts = line.split()
                total += float(parts[0].replace(',', '.'))
            if "seconds" in line:
                parts = line.split()
                seconds = float(parts[0].replace(',', '.'))
        
        energy_data.append({
            "Algorithm": sys.argv[1],
            "DatasetSize": item,
            "JoulesUsed": total,
            "SecondsElapsed": seconds,
        })


        
    df = pd.DataFrame(energy_data)
    output_file = "{0}_{1}.csv".format(sys.argv[1], run)
    df.to_csv(output_file, index=False)
    