import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/scanner/scanner_error.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pbp_widget_a_klmpk4/view/home/home.dart';
import 'package:pbp_widget_a_klmpk4/client/CartClient.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BarcodeScannerPageView extends StatefulWidget {
  BarcodeScannerPageView({
    Key? key,
    this.id,
  }) : super(key: key);

  int? id;
  @override
  State<BarcodeScannerPageView> createState() => _BarcodeScannerPageViewState();
}

class _BarcodeScannerPageViewState extends State<BarcodeScannerPageView>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcodeCapture;
  bool isScanning = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: PageView(
        children: [
          CameraView(),
          Container(),
        ],
      ),
    );
  }

  Widget CameraView() {
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            MobileScanner(
              startDelay: true,
              controller: MobileScannerController(torchEnabled: false),
              fit: BoxFit.contain,
              errorBuilder: (context, error, child) {
                return ScannerErrorWidget(error: error);
              },
              onDetect: (capture) {
                if (isScanning) {
                  setBarcodeCapture(capture);
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        height: 50,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void setBarcodeCapture(BarcodeCapture capture) {
    setState(() {
      barcodeCapture = capture;
      isScanning = false;
      final contain = barcodeCapture?.barcodes.first.rawValue;

      if (contain != null && contain.startsWith('PBP4//')) {
        _showSuccessDialog();
      } else {
        _showErrorDialog('Gagal Melakukan pembayaran!!');
      }
    });
  }

  void _showErrorDialog(String errorMessage) async {
    final player = AudioPlayer();
    await player.play(AssetSource('failed.mp3'));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isScanning = true;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() async {
    final scannerController = MobileScannerController(torchEnabled: false);
    isScanning = false;
    final player = AudioPlayer();
    await player.play(AssetSource('sucess.mp3'));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Berhasil membayar'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                Navigator.of(context).pop();
                scannerController;
                setState(() {
                  isScanning = false;
                });
                Fluttertoast.showToast(
                  msg: 'Pembayaran berhasil!',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green, // Warna latar belakang toast
                  textColor: Colors.white, // Warna teks toast
                );
                final cart = await CartClient.find(widget.id);
                await CartClient.destroy(cart.id);
                Navigator.push(
                  _scaffoldKey.currentContext!,
                  MaterialPageRoute(
                    builder: (context) => const Homepage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
