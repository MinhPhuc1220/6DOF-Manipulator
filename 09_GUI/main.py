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
import openpyxl

# class cấu hình nhúng matplotlib
class MplCanvas(FigureCanvas):
    def __init__(self, parent=None, width=5, height=4, dpi=100, name=''):
        fig = Figure(figsize=(width, height), dpi=dpi)
        fig.suptitle(name,fontsize=15)
        fig.patch.set_facecolor('#f1f1f1')
        
        self.ax1 = fig.add_subplot(321)
        self.ax1.set_xlim(-10,10)
        self.ax1.set_ylim(-10, 10)
        self.ax1.set_xlabel('Time',fontsize=12)
        self.ax1.set_ylabel(name + ' 1',fontsize=12)

        self.ax2 = fig.add_subplot(322)
        self.ax2.set_xlim(-10,10)
        self.ax2.set_ylim(-10, 10)
        self.ax2.set_xlabel('Time',fontsize=12)
        self.ax2.set_ylabel(name + ' 2',fontsize=12)

        self.ax3 = fig.add_subplot(323)
        self.ax3.set_xlim(-10,10)
        self.ax3.set_ylim(-10, 10)
        self.ax3.set_xlabel('Time',fontsize=12)
        self.ax3.set_ylabel(name + ' 3',fontsize=12)

        self.ax4 = fig.add_subplot(324)
        self.ax4.set_xlim(-10,10)
        self.ax4.set_ylim(-10, 10)
        self.ax4.set_xlabel('Time',fontsize=12)
        self.ax4.set_ylabel(name + ' 4',fontsize=12)

        self.ax5 = fig.add_subplot(325)
        self.ax5.set_xlim(-10,10)
        self.ax5.set_ylim(-10, 10)
        self.ax5.set_xlabel('Time',fontsize=12)
        self.ax5.set_ylabel(name + ' 5',fontsize=12)

        self.ax6 = fig.add_subplot(326)
        self.ax6.set_xlim(-10,10)
        self.ax6.set_ylim(-10, 10)
        self.ax6.set_xlabel('Time',fontsize=12)
        self.ax6.set_ylabel(name + ' 6',fontsize=12)
        
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
        self.sc_the = MplCanvas(self,width=15, height=10, dpi=80, name='Theta')
        self.ui.formlayout_the.addWidget(self.sc_the)      #QFormLayout
        self.sc_err = MplCanvas(self,width=15, height=10, dpi=80, name='Error')
        self.ui.formlayout_err.addWidget(self.sc_err)      #QFormLayout
        # khởi tạo các giá trị ban đầu 
        UIFunctions.uiDefinitions(self)

        # khởi chạy phân luồng
        # self.start_worker_receive()
        # self.start_worker_plot()

        # tạo chức năng cho button
        self.btn_connect.clicked.connect(lambda: UIFunctions.connect_stm(self))
        self.btn_start.clicked.connect(lambda: UIFunctions.start_receive(self))
        self.btn_stop.clicked.connect(lambda: UIFunctions.stop_receive(self))
        self.btn_disconnect.clicked.connect(lambda: UIFunctions.disconnect_stm(self))
        self.btn_page_the.clicked.connect(lambda: UIFunctions.show_page_the(self)) 
        self.btn_page_err.clicked.connect(lambda: UIFunctions.show_page_err(self))

    def plot_data(self):
        while True:
            # xoá hình plot đáp ứng
            self.sc_the.ax1.cla()  
            # plot đáp ứng
            self.sc_the.ax1.set_xlabel('Time',fontsize=12)
            self.sc_the.ax1.set_ylabel('Theta 1',fontsize=12)
            self.sc_the.ax1.plot(self.i, self.the1, 'r')
            self.sc_the.ax1.grid()

            self.sc_the.ax2.cla()       
            self.sc_the.ax2.set_xlabel('Time',fontsize=12)
            self.sc_the.ax2.set_ylabel('Theta 2',fontsize=12)
            self.sc_the.ax2.plot(self.i, self.the2, 'r')
            self.sc_the.ax2.grid()

            self.sc_the.ax3.cla()
            self.sc_the.ax3.set_xlabel('Time',fontsize=12)
            self.sc_the.ax3.set_ylabel('Theta 3',fontsize=12)
            self.sc_the.ax3.plot(self.i, self.the3, 'r')
            self.sc_the.ax3.grid()

            self.sc_the.ax4.cla()
            self.sc_the.ax4.set_xlabel('Time',fontsize=12)
            self.sc_the.ax4.set_ylabel('Theta 4',fontsize=12)
            self.sc_the.ax4.plot(self.i, self.the4, 'r')
            self.sc_the.ax4.grid()

            self.sc_the.ax5.cla()
            self.sc_the.ax5.set_xlabel('Time',fontsize=12)
            self.sc_the.ax5.set_ylabel('Theta 5',fontsize=12)
            self.sc_the.ax5.plot(self.i, self.the5, 'r')
            self.sc_the.ax5.grid()

            self.sc_the.ax6.cla()
            self.sc_the.ax6.set_xlabel('Time',fontsize=12)
            self.sc_the.ax6.set_ylabel('Theta 6',fontsize=12)
            self.sc_the.ax6.plot(self.i, self.the6, 'r')
            self.sc_the.ax6.grid()
            # cập nhập, plot lại đáp ứng
            self.sc_the.draw()

            # xoá hình plot đáp ứng
            self.sc_err.ax1.cla()  
            # plot đáp ứng
            self.sc_err.ax1.set_xlabel('Time',fontsize=12)
            self.sc_err.ax1.set_ylabel('Error 1',fontsize=12)
            self.sc_err.ax1.plot(self.i, self.the1, 'r')
            self.sc_err.ax1.grid()

            self.sc_err.ax2.cla()       
            self.sc_err.ax2.set_xlabel('Time',fontsize=12)
            self.sc_err.ax2.set_ylabel('Error 2',fontsize=12)
            self.sc_err.ax2.plot(self.i, self.the2, 'r')
            self.sc_err.ax2.grid()

            self.sc_err.ax3.cla()
            self.sc_err.ax3.set_xlabel('Time',fontsize=12)
            self.sc_err.ax3.set_ylabel('Error 3',fontsize=12)
            self.sc_err.ax3.plot(self.i, self.the3, 'r')
            self.sc_err.ax3.grid()

            self.sc_err.ax4.cla()
            self.sc_err.ax4.set_xlabel('Time',fontsize=12)
            self.sc_err.ax4.set_ylabel('Error 4',fontsize=12)
            self.sc_err.ax4.plot(self.i, self.the4, 'r')
            self.sc_err.ax4.grid()

            self.sc_err.ax5.cla()
            self.sc_err.ax5.set_xlabel('Time',fontsize=12)
            self.sc_err.ax5.set_ylabel('Error 5',fontsize=12)
            self.sc_err.ax5.plot(self.i, self.the5, 'r')
            self.sc_err.ax5.grid()

            self.sc_err.ax6.cla()
            self.sc_err.ax6.set_xlabel('Time',fontsize=12)
            self.sc_err.ax6.set_ylabel('Error 6',fontsize=12)
            self.sc_err.ax6.plot(self.i, self.the6, 'r')
            self.sc_err.ax6.grid()
            # cập nhập, plot lại đáp ứng
            self.sc_err.draw()

    # các hàm gọi luồng
    def start_worker_plot(self):
        worker_plot = Worker(self.plot_data,)
        self.threadpool_plot.start(worker_plot)
    def start_worker_receive(self):
        worker_receive = Worker(self.receive_data,)
        self.threadpool_receive.start(worker_receive)

    def receive_data(self):
        while self.ser.isOpen() and self.flag==1:
            try:
                if self.ser.in_waiting:
                    # in ra số byte mỗi chu kì nhận được
                    self.byte_input = self.ser.in_waiting
                    print(self.byte_input)
                    # xử lý dữ liệu nhận về và lưu vào biến kiểu list
                    self.data = self.ser.readline().decode().strip().split(',')
                    # làm sạch bộ đệm đầu vào, xoá tất cả nội dung
                    self.ser.flushInput()
                    # thời gian lấy mãu dữ liệu nhận về 0.1s (100ms)
                    time.sleep(0.1)  
                    if len(self.data) == 9 and self.data[0] == 'start' and self.data[8] == 'stop': 
                        # list để plot đáp ứng (append - thêm phần tử vào list)
                        self.i.append(float(self.data[1]))                    
                        self.the1.append(float(self.data[2]))
                        self.the2.append(float(self.data[3]))
                        self.the3.append(float(self.data[4]))
                        self.the4.append(float(self.data[5]))
                        self.the5.append(float(self.data[6]))
                        self.the6.append(float(self.data[7]))


                        # hiển thị theta liên tục theo tg thực 
                        self.le_time.setText(str(self.data[1]))
                        self.le_the1.setText(str(self.data[2]))
                        self.le_the2.setText(str(self.data[3]))
                        self.le_the3.setText(str(self.data[4]))
                        self.le_the4.setText(str(self.data[5]))
                        self.le_the5.setText(str(self.data[6]))
                        self.le_the6.setText(str(self.data[7]))

                        # tăng số thứ tự hàng theo từng chu kì lấy mẫu
                        self.line_data = self.line_data + 1  
                        # ghi dữ liệu vào file excel
                        cell_t    = ("A"+str(self.line_data))
                        cell_the1 = ("B"+str(self.line_data))
                        cell_the2 = ("C"+str(self.line_data))
                        cell_the3 = ("D"+str(self.line_data))
                        cell_the4 = ("E"+str(self.line_data))
                        cell_the5 = ("F"+str(self.line_data))
                        cell_the6 = ("G"+str(self.line_data))
                        cell_byte = ("H"+str(self.line_data))
                        # load file excel
                        wb = openpyxl.load_workbook('Data.xlsx')
                        # xử lý data trên sheet1
                        sheet1 = wb['Sheet1']
                        # thay đổi giá trị từng cell trong sheet1
                        sheet1["A1"].value="Time"
                        sheet1["B1"].value="Theta 1"
                        sheet1["C1"].value="Theta 2"
                        sheet1["D1"].value="Theta 3"
                        sheet1["E1"].value="Theta 4"
                        sheet1["F1"].value="Theta 5"
                        sheet1["G1"].value="Theta 6"
                        sheet1["H1"].value="Byte Input"
                        sheet1[cell_t].value    = float(self.data[1])
                        sheet1[cell_the1].value = float(self.data[2])
                        sheet1[cell_the2].value = float(self.data[3])
                        sheet1[cell_the3].value = float(self.data[4])
                        sheet1[cell_the4].value = float(self.data[5])
                        sheet1[cell_the5].value = float(self.data[6])
                        sheet1[cell_the6].value = float(self.data[7])
                        sheet1[cell_byte].value = float(self.byte_input)
                        # lưu lại dữ liệu vừa thêm
                        wb.close
                        wb.save('Data.xlsx')
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