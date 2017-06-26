import csv
import matplotlib.pyplot as plt

results = {
    'read' : {'x': [], 'y': []},
    'insert' : {'x': [], 'y': []},
    'delete' : {'x': [], 'y': []},
}

with open('sample_output.csv') as sample:
    csv_reader = csv.reader(sample)
    for row in csv_reader:
        if row[0] == 'read':
            results['read']['x'].append(row[1])
            results['read']['y'].append(row[2])

    plt.plot(results['read']['x'], results['read']['y'])
    plt.show()

