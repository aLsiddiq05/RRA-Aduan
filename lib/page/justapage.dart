import 'package:flutter/material.dart';
import 'package:rra_mobile/widget/customappbar.dart';

class JustAPage extends StatefulWidget {
  //const JustAPage({super.key});
  final String title;
  final int num;

  const JustAPage({super.key, required this.title, required this.num});

  @override
  State<JustAPage> createState() => _JustAPageState();
}

class _JustAPageState extends State<JustAPage> {
  late Widget currentContent;

//test
  @override
  void initState() {
    super.initState();
    switchingContent(widget.num);
  }

  void switchingContent(int num) {
    switch (num) {
      case 0:
        currentContent = contentmrr();
        break;
      case 1:
        currentContent = contentTA();
        break;
      case 2:
        currentContent = contentBK();
        break;
      case 3:
        currentContent = contentBPA();
        break;
      case 4:
        currentContent = contentTnC();
        break;
      case 5:
        currentContent = contentCalling();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Padding(
          padding: const EdgeInsets.all(25),
          child: Card(
            child: currentContent,
          )),
    );
  }

  Widget contentCalling() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('BIRO PENGADUAN AWAM', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]), textAlign: TextAlign.right,),
          Text(
            'Pusat Governans, Integriti dan Anti-Rasuah Nasional (GIACC)\n'
            'Jabatan Perdana Menteri\n'
            'Aras 2 dan 3\n'
            'Blok F10, Kompleks F\n'
            'Lebuh Perdana Timur, Presint 1\n'
            'Pusat Pentadbiran Kerajaan Persekutuan\n'
            '62000 Putrajaya\n\n'
            'Tel: 603 8000 8000\n'
            'Fax: 603 8888 3748, 8888 7778\n'
            'www.pcb.gov.my',
            style: TextStyle(color: Colors.blue[900]),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset("assets/img10.jpg", width: 400)
        ],
      ),
    );
  }

  Widget contentmrr() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Respons Rakyat adalah saluran digital mesra rakyat untuk orang awam mengemukakan aduan dan maklum balas kepada agensi kerajaan dengan mudah dan pantas.',
            style: TextStyle(color: Colors.blue[900]),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            ' Aplikasi Respons Rakyat membolehkan pengadu menyemak kedudukan semasa kes aduan dan menerima notifikasi kedudukan semasa kes aduan sewaktu kes dikendalikan oleh Biro Pengaduan Awam.',
            style: TextStyle(color: Colors.blue[900]),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.blueGrey[200],
            width: double.infinity,
            child: Text(
              'Penafian',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
              'Anda dinasihatkan untuk tidak menggunakan aplikasi ini semasa memandu. Kerajaan Malaysia dan Biro Pengaduan Awam tidak bertanggungjawab di atas segala kerugian atau kerosakan disebabkan penggunaan aplikasi ini.',
              style: TextStyle(color: Colors.blue[900])),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 150,
            height: 150,
            color: Colors.amber[100],
            child: const Icon(Icons.image),
          )
        ],
      ),
    );
  }

  Widget contentTnC() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Saya mengaku bahawa saya telah membaca dan memahami takrif aduan dan prosedur pengurusan aduan oleh pihak Kerajaan Malaysia. Segala maklumat diri dan maklumat perkara yang dikemukan oleh saya adalah benar dan saya bertanggungjawab ke atasnya.',
            style: TextStyle(color: Colors.blue[900]),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Kerajaan Malaysia tidak bertanggungjawab terhadap sebarang kehilangan atau kerosakan yang dialami kerana menggunakan perkhidmatan ini di dalam sistem. Semua maklumat akan dirahsiakan dan hanya akan digunakan oleh Kerajaan Malaysia',
            style: TextStyle(color: Colors.blue[900]),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset('assets/img9.png', width: 250),
        ],
      ),
    );
  }

  Widget contentTA() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Aduan Awam adalah aduan orang ramai mengenai ketidakpuasan mereka terhadap semua aspek pentadbiran Kerajaan (termasuk agensi-agensi yang diswastakan dan institusi-institusi yang berbentuk monopoli dan membekalkan keperluan-keperluan awam yang dirasai tidak adil, tidak mematuhi undang-undang dan peraturan vang sedia ada termasuk salah laku, penyelewengan, salahguna kuasa, salah tadbir dan seumpamanya. Pengaduan awam meliputi semua aspek pentadbiran kerajaan termasuk agensi Kerajaan yang diswastakan..',
            style: TextStyle(color: Colors.blue[900]),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey[200],
            ),
            child: Text(
              'Jenis-Jenis Aduan Yang Tidak Boleh Diterima',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
              'Perkara-perkara di bawah bidang Kuasa:\n'
              '1. Jawatankuasa Kira-kira Awam.\n'
              '2. Suruhanjaya Pencegahan Rasuah Malaysia.\n'
              '3. Jabatan Bantuan Guaman.\n'
              '4. Perkara berkenaan dasar Kerajaan yang telah ditetapkan.\n'
              '5. Masalah keluarga/Peribadi.\n'
              '6. Tuntutan Berbentuk "Civil" antara individu/syarikat.',
              style: TextStyle(color: Colors.blue[900])),
        ],
      ),
    );
  }

  Widget contentBK() {
    return const Center();
  }

  Widget contentBPA() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: RichText(
  text: TextSpan(
    style: TextStyle(
      color: Colors.blue[900],
      fontSize: 16, // Adjust the font size as needed
    ),
    children: const [
      TextSpan(
        text: 'Biro Pengaduan Awam',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text:
            ' merupakan sebuah agensi di bawah Pusat Governans, Integriti dan Anti-rasuah Nasional (GIACC), Jabatan Perdana Menteri yang mengurus dan menyelesaikan aduan/maklun balas orang ramai terhadap agensi-agensi awam.',
      ),
    ],
  ),
)

    );
  }
}
