import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _appBar(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _orderText('New Order', false),
                  _topContainer('Ojota, New Garage, Ikorodu',
                      'House B Ikate, Lekki, Lagos'),
                  _buttons(),
                  _topContainer('Shop 9, Balogun Ikeja, Airport Road',
                      'Ketu Tipper Garage, Ikorodu, Lagos'),
                  _buttons(),
                  const Divider(
                    thickness: 1,
                  ),
                  _orderText('Active Order', true),
                  _bottomContainer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 50),
      width: size.width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                HapticFeedback.vibrate();
                SystemSound.play(SystemSoundType.click);

                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 30.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            const Text(
              'NEW ORDERS',
              style: TextStyle(
                  color: Color.fromARGB(255, 182, 166, 122),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderText(String text, bool isShowTime) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          isShowTime ? const Text('3:43pm') : Container(),
        ],
      ),
    );
  }

  Widget _topContainer(String textBlue, String textGreen) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: size.width,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey.shade400.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    '₦ 2800',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 100),
                  Text('5.3km'),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: true,
                checkColor: Colors.blue.shade300,
                activeColor: Colors.blue.shade300,
                onChanged: (value) => true,
              ),
              Text(textBlue),
              const Icon(Icons.chevron_right, size: 30)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: true,
                checkColor: Colors.green.shade300,
                activeColor: Colors.green.shade300,
                onChanged: (value) => true,
              ),
              Text(textGreen),
              Icon(
                Icons.circle_outlined,
                size: 35,
                color: Colors.blue.shade200,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttons() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pushReplacement(
                    //   PageTransition(
                    //     child: const BottomNav(),
                    //     type: PageTransitionType.fade,
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.black,
                    shadowColor: Colors.grey,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade100, Colors.green.shade100],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pushReplacement(
                    //   PageTransition(
                    //     child: const BottomNav(),
                    //     type: PageTransitionType.fade,
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.blue.shade300,
                    shadowColor: Colors.grey,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.red.shade100)),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red.shade100, Colors.red.shade100],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Decline',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomContainer() {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: size.width,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.green.shade200.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text('ORDER NUMBER:', style: TextStyle(fontSize: 12)),
                  SizedBox(width: 5),
                  Text('7373',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: true,
                checkColor: Colors.blue.shade300,
                activeColor: Colors.blue.shade300,
                onChanged: (value) => true,
              ),
              const Text('2 Allen Avenue, Toyin Roundaboud,\nIkeja, Lagos')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: true,
                checkColor: Colors.green.shade300,
                activeColor: Colors.green.shade300,
                onChanged: (value) => true,
              ),
              const Text('Victoria Island, Lagos')
            ],
          ),
        ],
      ),
    );
  }
}
