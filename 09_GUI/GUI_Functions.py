from main import *




class UIFunctions(MainWindow):
    def show_page_the(self):
        self.ui.stackedWidget.setCurrentWidget(self.page_the)
    def show_page_err(self):
        self.ui.stackedWidget.setCurrentWidget(self.page_err)

    def Serial_connect(self,comm,baud):
        self.ser.port = comm
        self.ser.baudrate =  baud
        self.ser.bytesize = serial.EIGHTBITS #number of bits per bytes
        self.ser.parity = serial.PARITY_NONE #set parity check: no parity
        self.ser.stopbits = serial.STOPBITS_ONE #number of stop bits            #timeout block read
        self.ser.xonxoff = False     #disable software flow control
        self.ser.rtscts = False     #disable hardware (RTS/CTS) flow control
        self.ser.dsrdtr = False       #disable hardware (DSR/DTR) flow control
        self.ser.writeTimeout = 0    #timeout for write
        self.ser.timeout = 0
        self.ser.open()
        
    def list_port(self):
        ports = serial.tools.list_ports.comports()
        self.commPort =([comport.device for comport in serial.tools.list_ports.comports()])
        self.numConnection = len(self.commPort)
        if  self.numConnection == 0 :
            pass
        elif self.numConnection == 1 :
            self.cb_comports.addItem(str(self.commPort[0]))
        else:
            self.cb_comports.addItem(str(self.commPort[0]))
            self.cb_comports.addItem(str(self.commPort[1]))

    def connect_stm(self):
        comport = self.cb_comports.currentText()
        baurate = self.cb_baudrates.currentText()
        self.chb_status.setChecked(False)
        self.chb_status.setEnabled(False)
        # self.btnstart_simu.setEnabled(False)
        UIFunctions.Serial_connect(self,comport,baurate)
        if self.ser.isOpen():
            self.chb_status.setChecked(True)
            self.lbl_status.setText('Connected')
            # if self.mode_check.isChecked() == False:
            #     self.start_worker_2()
            #     time.sleep(0.1)
            #     self.start_worker_read()
            # x = -11.8
            # y = 0.0
            # z = 13.1
            # yaw=0; pitch =0 ;roll = 0
            # self.xposvalue.setText(str(x))
            # self.yposvalue.setText(str(y))
            # self.zposvalue.setText(str(z))
            # self.btnconnect_arduino.setStyleSheet('QPushButton {background-color:#1eff1e; color: white;}') 
            # self.btn_disconnect_arduino.setStyleSheet('QPushButton {background-color:#1b1d23; color: white;}') 
            print("Connected Arduino")

    def disconnect_stm(self):
            self.ser.close()
            if not self.ser.isOpen():
                self.chb_status.setEnabled(False)
                self.chb_status.setChecked(False)
                self.lbl_status.setText('Disconnected')
                print("Disconnected Arduino")
                # self.xposvalue.clear()
                # self.yposvalue.clear()
                # self.zposvalue.clear()
                # self.valuethe1.clear()
                # self.valuethe2.clear()
                # self.valuethe3.clear()
                # self.valuethe4.clear()
                # self.valuethe5.clear()
                # self.valuethe6.clear()
                self.cb_comports.setCurrentIndex(0)
                self.cb_baudrates.setCurrentIndex(0)
    def start_receive(self):
        self.flag = 1
        # xo?? b???ng excel
        wb = openpyxl.load_workbook('Data.xlsx')
        sheet1 = wb['Sheet1']
        # sheet1.delete_cols(1,7) # xo?? t??? c???t A:G
        sheet1.delete_rows(2,99999999)
        wb.close
        wb.save('Data.xlsx')
        if self.ser.isOpen() :
            self.ser.write('1'.encode())
            self.ser.flushInput()
            self.ser.flushOutput()
            print("Start Receive")
        self.start_worker_receive()
        self.start_worker_plot()

    def stop_receive(self):
        print("Stop Receive")
        if self.ser.isOpen() and self.flag==1:
            self.ser.write('0'.encode())
            self.flag=0
            self.line_data=0

    def uiDefinitions(self):
        self.line_data = 1
        self.the1 = list()
        self.the2 = list()
        self.the3 = list()
        self.the4 = list()
        self.the5 = list()
        self.the6 = list()
        self.i    = list()
        # kh???i t???o ph??n lu???ng 
        self.threadpool_plot = QtCore.QThreadPool()
        self.threadpool_receive = QtCore.QThreadPool()
        # kh???i t???o b??o serial
        self.ser =  serial.Serial()
        UIFunctions.list_port(self)
        

