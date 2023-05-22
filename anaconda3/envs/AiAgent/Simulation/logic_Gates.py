import sys
import tensorflow as tf
import numpy as np
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QPushButton, QComboBox, QTableWidget, QTableWidgetItem
tf.compat.v1.enable_eager_execution()
# Define logic gates
def NOT(a):
    return not a

def AND(a, b):
    if a == 1 and b == 1:
        return 1
    else:
        return 0

def OR(a, b):
    if a == 1 or b ==1:
        return 1
    else:
        return 0
  
def NAND (a, b):
    if a == 1 and b == 1:
        return 0
    else:
        return 1
        
def NOR(a, b):
    if(a == 0) and (b == 0):
        return 1
    elif(a == 0) and (b == 1):
        return 0
    elif(a == 1) and (b == 0):
        return 0
    elif(a == 1) and (b == 1):
        return 0

def XOR (a, b):
    if a != b:
        return 1
    else:
        return 0
# Define truth table patterns
patterns = np.array([[0, 0], [0, 1], [1, 0], [1, 1]], dtype=np.float32)

# Define target truth table for AND gate
target = np.array([0, 0, 0, 1], dtype=np.float32)

class SimulatorGUI(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setWindowTitle('Logic Gate Simulator')
        self.setGeometry(100, 100, 600, 400)

        # Create labels for input and output
        input_label = QLabel('Inputs:', self)
        input_label.move(20, 20)

        output_label = QLabel('Output:', self)
        output_label.move(20, 70)

        # Create a combo box for selecting the logic gate
        gate_label = QLabel('Logic Gate:', self)
        gate_label.move(20, 120)

        self.gate_combo = QComboBox(self)
        self.gate_combo.addItem('AND')
        self.gate_combo.addItem('OR')
        self.gate_combo.addItem('NOT')
        self.gate_combo.addItem('NAND')
        self.gate_combo.addItem('NOR')
        self.gate_combo.addItem('XOR')
        self.gate_combo.move(100, 120)

        # Create a table widget for displaying the truth table
        table_label = QLabel('Truth Table:', self)
        table_label.move(20, 170)

        self.table_widget = QTableWidget(self)
        self.table_widget.setRowCount(4)
        self.table_widget.setColumnCount(3)
        self.table_widget.setHorizontalHeaderLabels(['Input1', 'Input2', 'Output'])
        self.table_widget.setItem(0, 0, QTableWidgetItem('0'))
        self.table_widget.setItem(0, 1, QTableWidgetItem('0'))
        self.table_widget.setItem(1, 0, QTableWidgetItem('0'))
        self.table_widget.setItem(1, 1, QTableWidgetItem('1'))
        self.table_widget.setItem(2, 0, QTableWidgetItem('1'))
        self.table_widget.setItem(2, 1, QTableWidgetItem('0'))
        self.table_widget.setItem(3, 0, QTableWidgetItem('1'))
        self.table_widget.setItem(3, 1, QTableWidgetItem('1'))
        self.table_widget.move(20, 200)

        # Create buttons for simulation and training
        sim_button = QPushButton('Simulate', self)
        sim_button.move(400, 120)

        train_button = QPushButton('Train', self)
        train_button.move(500, 120)

        # Connect buttons to functions
        sim_button.clicked.connect(self.simulate)
        train_button.clicked.connect(self.train)

        # Show the GUI
        self.show()
    def simulate(self):
        if self.model is None:
            return
        
        # Get inputs from table widget
        inputs = []
        for row in range(self.table_widget.rowCount()):
            input1 = int(self.table_widget.item(row, 0).text())
            input2 = int(self.table_widget.item(row, 1).text())
            inputs.append([input1, input2])

        # Normalize inputs and convert to numpy array
        inputs = np.array(inputs)
        inputs = inputs / np.max(inputs)

        # Predict output using trained model
        outputs = self.model.predict(inputs)

        # Display output in table widget
        for row in range(self.table_widget.rowCount()):
            output = round(outputs[row][0])
            self.table_widget.setItem(row, 2, QTableWidgetItem(str(output)))

    def train(self):
        # Define initial weights and biases for neural network
        w1 = tf.Variable(tf.random.normal([2, 4], stddev=0.1))
        b1 = tf.Variable(tf.zeros([4]))
        w2 = tf.Variable(tf.random.normal([4, 1], stddev=0.1))
        b2 = tf.Variable(tf.zeros([1]))

        # Define optimizer and loss function
        optimizer = tf.keras.optimizers.Adam(learning_rate=0.1)
        loss_fn = tf.keras.losses.MeanSquaredError()

        # Train neural network
        for i in range(1000):
            with tf.GradientTape() as tape:
                # Forward pass
                hidden_layer = tf.sigmoid(tf.matmul(patterns, w1) + b1)
                output_layer = tf.sigmoid(tf.matmul(hidden_layer, w2) + b2)

                # Compute loss and gradients
                loss = loss_fn(target, output_layer)
                gradients = tape.gradient(loss, [w1, b1, w2, b2])

                # Update weightsand biases using gradients
                optimizer.apply_gradients(zip(gradients, [w1, b1, w2, b2]))

        # Set trained weights in model
        self.model = tf.keras.Sequential([
            tf.keras.layers.Dense(4, activation=tf.nn.sigmoid, input_shape=(2,)),
            tf.keras.layers.Dense(1, activation=tf.nn.sigmoid)
        ])
        self.model.set_weights([w1.numpy(), b1.numpy(), w2.numpy(), b2.numpy()])

        # Simulate using trained model
        self.simulate()
       
if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = SimulatorGUI()
    sys.exit(app.exec_())




