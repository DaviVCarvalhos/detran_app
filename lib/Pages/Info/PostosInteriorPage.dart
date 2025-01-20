import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PostosInteriorPage extends StatelessWidget {
  const PostosInteriorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFBEE5EB),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              InfoCard(
                title: '1ª CIRETRAN - MOSSORÓ',
                address:
                    'Terminal Rodoviário Mossoró - de, Estr. do Contôrno, 1020 - Aeroporto, Mossoró - RN, 59600-971',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-5.185629856665561, -37.37400671874656),
              ),
              InfoCard(
                title: '2ª CIRETRAN - CAICÓ',
                address:
                    'Rua Marina Neves Dantas, nº 35, Central do Cidadão, Maynard, 59.300-000',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-6.477623486694452, -37.07853858804198),
              ),
              InfoCard(
                title: '3ª CIRETRAN - NOVA CRUZ',
                address:
                    'R. Dep. Djalma Marinho, 46, Nova Cruz - RN, 59215-000',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-6.4850658871429765, -35.43040551131389),
              ),
              InfoCard(
                title: '4ª CIRETRAN - CURRAIS NOVOS',
                address: 'Rua Tomaz do O, nº 18, JK, 59.380-000',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-6.254607334429272, -36.518303530371604),
              ),
              InfoCard(
                title: '5ª CIRETRAN - PAU DOS FERROS',
                address:
                    'R. Carloto Fernandes Távora, 877 - São Benedito, Pau dos Ferros - RN, 59900-000',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-6.117685297332101, -38.20297117455498),
              ),
              InfoCard(
                title: 'APODI',
                address:
                    'Rua Deputado Dalton Cunha, nº 41, Portal da Chapada, 59.700-000',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-5.693812438866801, -35.8201148517951),
              ),
              InfoCard(
                title: 'AÇÚ',
                address:
                    'Av. Sen. João Severian da Câmara, Açu - RN, 59650-000',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-5.575687710167941, -36.92294491032717),
              ),
              InfoCard(
                title: 'CANGUARETAMA',
                address:
                    'Av. Nossa Senhora da Conceição, 44, Canguaretama - RN, 59190-000',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-6.372557605305452, -35.14379488989795),
              ),
              InfoCard(
                title: 'CEARÁ-MIRIM',
                address: 'Rua Luiz Lopes Varela, nº 290, Centro, 59.570-000',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-5.63740559474333, -35.41993068116747),
              ),
              InfoCard(
                title: 'GOIANINHA',
                address:
                    'R. Prof. João Tibúrcio, 19, Goianinha - RN, 59173-000',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-6.265537569265145, -35.21069575920793),
              ),
              InfoCard(
                title: 'MACAÍBA',
                address: 'R. da Conceição, 124, Macaíba - RN, 59280-000',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-5.857400965926267, -35.35337091867808),
              ),
              InfoCard(
                title: 'PARELHAS',
                address:
                    'R. Laurentino Bezerra, 160 - Centro, Parelhas - RN, 59360-000',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-6.690194568191267, -36.657347761057906),
              ),
              InfoCard(
                title: 'SÃO JOSÉ DE MIPIBU',
                address:
                    'Av. Moizaniel de Carvalho, 366 - Manoel Alves de Souza, São José de Mipibu - RN, 59162-000',
                hours: 'Segunda a Sexta, das 07h às 13h.',
                location: LatLng(-6.036912574405717, -35.145573552476385),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatefulWidget {
  final String title;
  final String address;
  final String hours;
  final LatLng location;

  const InfoCard({
    Key? key,
    required this.title,
    required this.address,
    required this.hours,
    required this.location,
  }) : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool showMap = false;

  void _launchMaps() async {
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=${widget.location.latitude},${widget.location.longitude}';
    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Não foi possível abrir o Google Maps.';
    }
  }

  void _showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Abrir localização no Google Maps?'),
      action: SnackBarAction(
        label: 'ABRIR',
        onPressed: _launchMaps,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showMap = !showMap;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.address,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        widget.hours,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(Icons.touch_app, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'Toque para ver o mapa',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (showMap) ...[
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _showSnackbar(context),
                child: SizedBox(
                  height: 200,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: widget.location,
                      zoom: 16,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId(widget.title),
                        position: widget.location,
                      ),
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
