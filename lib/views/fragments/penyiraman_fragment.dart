part of 'fragment.dart'; // Sesuaikan dengan path file provider Anda

class PenyiramanFragment extends StatefulWidget {
  const PenyiramanFragment({Key? key}) : super(key: key);

  @override
  _PenyiramanFragmentState createState() => _PenyiramanFragmentState();
}

class _PenyiramanFragmentState extends State<PenyiramanFragment> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      Provider.of<SensorProvider>(context, listen: false).getDataSensor();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penyiraman Otomatis',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(175, 245, 237, 1),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => {homepageKey.currentState!.setSelectedIndex(0)},
        ),
        elevation: 0,
      ),
      body: Center(
        child: Consumer<SensorProvider>(
          builder: (context, sensorProvider, _) {
            return ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              children: [
                Text(
                  'Nilai kelembapan tanah',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Align(
                  child: Container(
                    width: 240,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _getSpeedoImage(sensorProvider.dataSensor.nilaiKelembapan),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: sensorProvider.dataSensorNotifier,
                  builder: (context, Sensor sensor, _) {
                    return Text(
                      '${sensor.nilaiKelembapan != null ? sensor.nilaiKelembapan.toString() : 'N/A'}',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  child: Container(
                    width: 240,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(175, 245, 237, 1),
                    ),
                    child: Center(
                      child: Text(
                        '${sensorProvider.dataSensor.nilaiKelembapan != null && sensorProvider.dataSensor.nilaiKelembapan > 600 ? 'KONDISI TANAH KERING' : 'KONDISI TANAH BASAH'}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 110,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(0, 133, 117, 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Pompa',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${sensorProvider.dataSensor.nilaiKelembapan != null && sensorProvider.dataSensor.nilaiKelembapan > 600 ? 'ON' : 'OFF'}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 110,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(0, 133, 117, 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Air',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${sensorProvider.dataSensor.nilaiKelembapan != null && sensorProvider.dataSensor.nilaiKelembapan > 600 ? 'HIDUP' : 'MATI'}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  AssetImage _getSpeedoImage(int? nilaiKelembapan) {
  if (nilaiKelembapan != null) {
    if (nilaiKelembapan >= 0 && nilaiKelembapan <= 25) {
      return AssetImage('img/speedo1.png');
    } else if (nilaiKelembapan >= 26 && nilaiKelembapan <= 50) {
      return AssetImage('img/speedo2.png');
    } else if (nilaiKelembapan >= 51 && nilaiKelembapan <= 75) {
      return AssetImage('img/speedo3.png');
    } else if (nilaiKelembapan >= 76 && nilaiKelembapan <= 100) {
      return AssetImage('img/speedo4.png');
    }
  }
  // Return default image if nilaiKelembapan tidak berada di dalam rentang yang diinginkan
  return AssetImage('img/default_image.png');
}

}