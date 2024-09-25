import 'package:flutter/material.dart';

class Informasi extends StatelessWidget {
  const Informasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('MRR button!!!!!!!!!!!!!!!!!!!!!!!!');
                      Navigator.pushNamed(context, '/mrr');
                    },
                    child: ListTile(
                      leading: Image.asset('assets/Logo.jpg', width: 30, height: 30,),
                      title: Text('Mengenai Respons Rakyat',
                          style: TextStyle(color: Colors.blue[900])),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Takrifan aduan');
                      Navigator.pushNamed(context, '/ta');
                    },
                    child: ListTile(
                      leading: Image.asset('assets/img1.png', width: 30, height: 30,),
                      title: Text('Takrifan Aduan/Maklum Balas',
                          style: TextStyle(color: Colors.blue[900])),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Bidang Kuasa');
                      Navigator.pushNamed(context, '/bk');
                    },
                    child: ListTile(
                      leading: Image.asset('assets/img2.png', width: 30, height: 30,),
                      title: Text('Bidang Kuasa',
                          style: TextStyle(color: Colors.blue[900])),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('M BPA');
                      Navigator.pushNamed(context, '/mbpa');
                    },
                    child: ListTile(
                      leading: Image.asset('assets/img3.png', width: 30, height: 30,),
                      title: Text('Mengenai BPA',
                          style: TextStyle(color: Colors.blue[900])),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Terma dan Syarat');
                      Navigator.pushNamed(context, '/tnc');
                    },
                    child: ListTile(
                      leading: Image.asset('assets/img4.png', width: 30, height: 30,),
                      title: Text('Terma dan Syarat',
                          style: TextStyle(color: Colors.blue[900])),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Hubungi kami');
                      Navigator.pushNamed(context, '/call');
                    },
                    child: ListTile(
                      leading:Image.asset('assets/img5.png', width: 30, height: 30,),
                      title: Text('Hubungi Kami',
                          style: TextStyle(color: Colors.blue[900])),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Versi Aplikasi',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900]),
                  ),
                  ListTile(
                    leading: Image.asset('assets/img6.png', width: 30, height: 30,),
                    title: const Text('v 2.6.8'),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
