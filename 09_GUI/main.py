# import các thư viện cần thiết: các thư viện hệ thống, các thư viện hỗ trợ threading (phân luồng), 
# import thư viện hỗ trợ kết nối serial, thư viện để vẽ hình matplotlib, thư viện hỗ trợ tính toán numpy
import sys
import random
import matplotlib
import serial
import serial.tools.list_ports
import numpy as np
import time
# import các thư viện cần thiết hỗ trợ nhúng hình vẽ 3D từ matplotlib vào GUI
from matplotlib import cm
matplotlib.use('Qt5Agg')
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure
import matplotlib.ticker as ticker
from matplotlib.animation import FuncAnimation
# import các thư viện Pyqt5 để hỗ trợ lập trình GUI của hệ thống điều khiển ROBOT
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtCore import (QCoreApplication, QPropertyAnimation, QDate, QDateTime, QMetaObject, QObject, QPoint, QRect, QSize, QTime, QUrl, Qt, QEvent)
from PyQt5.QtGui import (QBrush, QColor, QConicalGradient, QCursor, QFont, QFontDatabase, QIcon, QKeySequence, QLinearGradient, QPalette, QPainter, QPixmap, QRadialGradient)
from PyQt5.QtWidgets import *
from PyQt5 import uic
from PyQt5.QtCore import pyqtSlot
# import thư viện GUI_Functions
from GUI_Functions import *

# class cấu hình nhúng matplotlib
class MplCanvas(FigureCanvas):
    def __init__(self, parent=None, width=5, height=4, dpi=100):
        fig = Figure(figsize=(width, height), dpi=dpi)
        fig.suptitle('Theta',fontsize=15)
        fig.patch.set_facecolor('#f1f1f1')
        
        self.ax1 = fig.add_subplot(321)
        self.ax1.set_xlim(-10,10)
        self.ax1.set_ylim(-10, 10)
        self.ax1.set_xlabel('Time',fontsize=12)
        self.ax1.set_ylabel('Theta 1',fontsize=12)

        self.ax2 = fig.add_subplot(322)
        self.ax2.set_xlim(-10,10)
        self.ax2.set_ylim(-10, 10)
        self.ax2.set_xlabel('Time',fontsize=12)
        self.ax2.set_ylabel('Theta 2',fontsize=12)

        self.ax3 = fig.add_subplot(323)
        self.ax3.set_xlim(-10,10)
        self.ax3.set_ylim(-10, 10)
        self.ax3.set_xlabel('Time',fontsize=12)
        self.ax3.set_ylabel('Theta 3',fontsize=12)

        self.ax4 = fig.add_subplot(324)
        self.ax4.set_xlim(-10,10)
        self.ax4.set_ylim(-10, 10)
        self.ax4.set_xlabel('Time',fontsize=12)
        self.ax4.set_ylabel('Theta 4',fontsize=12)

        self.ax5 = fig.add_subplot(325)
        self.ax5.set_xlim(-10,10)
        self.ax5.set_ylim(-10, 10)
        self.ax5.set_xlabel('Time',fontsize=12)
        self.ax5.set_ylabel('Theta 5',fontsize=12)

        self.ax6 = fig.add_subplot(326)
        self.ax6.set_xlim(-10,10)
        self.ax6.set_ylim(-10, 10)
        self.ax6.set_xlabel('Time',fontsize=12)
        self.ax6.set_ylabel('Theta 6',fontsize=12)
        
        super(MplCanvas, self).__init__(fig)
        fig.tight_layout()

class Background(QMainWindow):
    def __init__(self):
        QMainWindow.__init__(self)
        # load giao điện tạo từ file .ui
        self.ui = uic.loadUi('DR3_Background.ui',self)  
        # đặt icon của giao diện
        self.setWindowIcon(QtGui.QIcon('robotics.png')) 
        # đặt tên giao diện                
        self.setWindowTitle('6DOF Controller')      
        # sự kiện nhấn nút btn_start: khởi chạy màn hình điều khiển chính                 
        self.ui.btn_start.clicked.connect(self.show_screen)   

    # sự kiện khi kích hoạt nút nhấn btn_start
    def show_screen(self):        
        # khởi chạy màn hình giao diện MainWindow  
        self.main = MainWindow()    
        self.main.show()
        # đóng lại màn hình giao diện Background
        self.close()                

class MainWindow(QMainWindow):
    def __init__(self):
        QMainWindow.__init__(self)
        # load giao điện tạo từ file .ui
        self.ui = uic.loadUi('GUI_6DOF.ui',self)
        # cài đặt size cho giao diện
        self.ui.resize(1600, 800)
        # đặt icon của giao diện
        self.setWindowIcon(QtGui.QIcon('robotics.png'))
        # đặt tên giao diện
        self.setWindowTitle('6DOF Controller')
        # khởi tạo các giá trị cần thiết để vẽ đáp ứng trong giao diện
        self.sc = MplCanvas(self,width=15, height=10, dpi=80)
        self.ui.formlayout_the.addWidget(self.sc)      #QFormLayout
        # khởi tạo các giá trị ban đầu 
        UIFunctions.uiDefinitions(self)

        # khởi chạy phân luồng
        self.start_worker()
        self.start_worker_1()

        # tạo chức năng cho button
        self.btn_connect.clicked.connect(lambda: UIFunctions.connect_arduino_clicked(self))
        self.btn_disconnect.clicked.connect(lambda: UIFunctions.disconnect_arduino_clicked(self))

    def update_plot(self):
        # xoá hình plot đáp ứng
        self.sc.ax1.cla()  
        # plot đáp ứng
        self.sc.ax1.set_xlabel('Time',fontsize=12)
        self.sc.ax1.set_ylabel('Theta 1',fontsize=12)
        self.sc.ax1.plot(self.x1, self.the1, 'r')

        self.sc.ax2.cla()       
        self.sc.ax2.set_xlabel('Time',fontsize=12)
        self.sc.ax2.set_ylabel('Theta 2',fontsize=12)
        self.sc.ax2.plot(self.x1, self.the2, 'r')

        self.sc.ax3.cla()
        self.sc.ax3.set_xlabel('Time',fontsize=12)
        self.sc.ax3.set_ylabel('Theta 3',fontsize=12)
        self.sc.ax3.plot(self.x1, self.the3, 'r')

        self.sc.ax4.cla()
        self.sc.ax4.set_xlabel('Time',fontsize=12)
        self.sc.ax4.set_ylabel('Theta 4',fontsize=12)
        self.sc.ax4.plot(self.x1, self.the4, 'r')

        self.sc.ax5.cla()
        self.sc.ax5.set_xlabel('Time',fontsize=12)
        self.sc.ax5.set_ylabel('Theta 5',fontsize=12)
        self.sc.ax5.plot(self.x1, self.the5, 'r')

        self.sc.ax6.cla()
        self.sc.ax6.set_xlabel('Time',fontsize=12)
        self.sc.ax6.set_ylabel('Theta 6',fontsize=12)
        self.sc.ax6.plot(self.x1, self.the6, 'r')
        # cập nhập, plot lại đáp ứng
        self.sc.draw()

    # các hàm gọi luồng
    def start_worker(self):
        worker = Worker(self.start_stream,)
        self.threadpool.start(worker)
    def start_worker_1(self):
        worker_1 = Worker(self.stream_data_arduino,)
        self.threadpool_1.start(worker_1)

    def start_stream(self):
        while True:
            try:
                # thiết lập timer để kích hoạt hàm update_plot
                self.update_plot() 
                self.timer = QtCore.QTimer()
                self.timer.setInterval(100)
                self.timer.timeout.connect(self.update_plot)
                self.timer.start()
            except :
                pass
    # def start_stream_data_arduino(self):
    #     while  self.ser.isOpen():
    #         print('Hello stream data')
    #         try:
    #             strdata = self.ser.readline().decode()
    #             print(strdata)
    #             time.sleep(0.1)
    #         except:
    #             pass

    def stream_data_arduino(self):
        while True:
            try:
                if self.ser.in_waiting:
                    # xử lý dữ liệu nhận về và lưu vào biến kiểu list
                    self.data = self.ser.readline().decode().strip().split(',')
                    # thời gian lấy mãu dữ liệu nhận về 0.1s (100ms)
                    time.sleep(0.1)  
                    if len(self.data) == 6: 
                        # list để plot đáp ứng (append - thêm phần tử vào list)
                        self.x1.append(self.t)                    
                        self.the1.append(float(self.data[0]))
                        self.the2.append(float(self.data[1]))
                        self.the3.append(float(self.data[2]))
                        self.the4.append(float(self.data[3]))
                        self.the5.append(float(self.data[4]))
                        self.the6.append(float(self.data[5]))
                        # cập nhập thời gian
                        self.t += 0.01
                    # # giới hạn số phần tử để hiển thị trên hình plot (không cần thiết)    
                    # if len(self.the1) > 500:
                    #     self.the1.pop(0)
                    #     self.the2.pop(0)
                    #     self.the3.pop(0)
                    #     self.the4.pop(0)
                    #     self.the5.pop(0)
                    #     self.the6.pop(0)
                    #     self.x1.pop(0)
            except:
                pass


# class phân luồng hệ thống 
class Worker(QtCore.QRunnable):
	def __init__(self, function, *args, **kwargs):
		super(Worker, self).__init__()
		self.function = function
		self.args = args
		self.kwargs = kwargs
	@pyqtSlot()
	def run(self):
		self.function(*self.args, **self.kwargs)


# Hàm chính để khởi chạy giao diện hệ thống
if __name__=="__main__":
    app = QApplication(sys.argv)
    window = Background()
    window.show()
    sys.exit(app.exec_())