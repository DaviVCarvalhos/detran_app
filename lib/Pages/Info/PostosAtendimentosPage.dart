import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PostosAtendimentoPage extends StatelessWidget {
  const PostosAtendimentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFBEE5EB),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                title: 'SEDE-DETRAN/RN',
                address:
                    'Av. Perimetral Leste, 113, Cidade da Esperança, Natal/RN, 59071-445',
                hours: 'Segunda a Sexta, das 8 às 14h.',
                location: LatLng(-5.825227504805629, -35.24275483151979),
              ),
              InfoCard(
                title: 'CENTRAL DO CIDADÃO ZONA SUL',
                address:
                    'Avenida Governador José Varela, nº 2900, Capim Macio (por trás da Comjol, da Av. Engenheiro Roberto Freire)',
                hours: 'Segunda a Sexta, das 07h às 18h.',
                location: LatLng(-5.852767235988536, -35.200048251793554),
              ),
              InfoCard(
                title: 'CENTRAL DO CIDADÃO ALECRIM',
                address:
                    'Av. Cel. José Bernardo, 1001 - Alecrim, Natal - RN, 59037-000',
                hours: 'Segunda a Sexta, das 07h às 17h.',
                location: LatLng(-5.792107211786082, -35.208647993667064),
              ),
              InfoCard(
                title: 'CENTRAL DO CIDADÃO ZONA NORTE',
                address:
                    'Av. Doutor João Medeiros Filho, 896, Potengi (em frente à área de lazer do Panatis)',
                hours: 'Segunda a Sexta, das 07h às 19h.',
                location: LatLng(-5.767184150792891, -35.25364098670262),
              ),
              InfoCard(
                title: '3ª CIRETRAN - PARNAMIRIM',
                address:
                    'Av. Tenente Medeiros, s/n, Centro, Parnamirim/RN, 59.140-000',
                hours: 'Segunda a Sexta, das 08h às 14h.',
                location: LatLng(-5.913955515957638, -35.25938709091811),
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
