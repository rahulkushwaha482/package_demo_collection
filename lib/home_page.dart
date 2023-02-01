import 'package:bmi/bmi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:location_provider/location_provider.dart';
import 'package:social_link/social_link.dart';

class HomePage extends HookWidget {
  void _update({
    required ValueNotifier<TextEditingValue> widthController,
    required ValueNotifier<TextEditingValue> heightController,
    required ValueNotifier<TextEditingValue> bmiController,
  }) {
    final weight = double.tryParse(widthController.value.text);
    final height = double.tryParse(heightController.value.text);
    if (weight != null && height != null) {
      final bmi = calculateBMI(weight, height);
      final formatted = formattedBmi(bmi);
      bmiController.value = TextEditingValue(text: formatted);
    } else {
      bmiController.value = TextEditingValue(text: '');
    }
  }

  void _updateAddress({
    required ValueNotifier<TextEditingValue> latitudeController,
    required ValueNotifier<TextEditingValue> longitudeController,
    required ValueNotifier<String> address,
  }) async {
    final lat = double.tryParse(latitudeController.value.text);
    final lan = double.tryParse(longitudeController.value.text);
    if (lat != null && lan != null) {
      final addre = await LocationHelper.getLocationFullAddress(lat, lan);
      address.value = addre.toString();
    } else {
      address.value = 'address';
    }
  }

  void _updateLatLng({
    required ValueNotifier<TextEditingValue> addressController,
    required ValueNotifier<String> lat,
    required ValueNotifier<String> lang,
  }) async{

    final address = (addressController.value.text);

    if (address != null ) {
      final addre = await LocationHelper.getLatitudeFromAddress(address);
      final lng = await LocationHelper.getLongitudeFromAddress(address);
      lat.value = addre.toString();
      lang.value = lng.toString();
    } else {
      lat.value = '';
      lang.value = '';
    }

  }

  @override
  Widget build(BuildContext context) {
    final address = useState('Address');
    final lat = useState('');
    final lan = useState('');
    final weightController = useTextEditingController();
    final heightController = useTextEditingController();
    final bmiController = useTextEditingController();
    final latitudeController = useTextEditingController();
    final longitudeController = useTextEditingController();
    final addressController = useTextEditingController();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // ColorContainer(
              //   childContainer: Text(
              //     'BMI Calculator',
              //     style: TextStyle(fontSize: 16, color: Colors.white),
              //   ),
              //   colordContainer: Colors.teal,
              // ),
              // TextField(
              //   controller: weightController,
              //   decoration: InputDecoration(labelText: 'Weight (kg)'),
              //   keyboardType: TextInputType.number,
              //   onChanged: (_) => _update(
              //       widthController: weightController,
              //       heightController: heightController,
              //       bmiController: bmiController),
              //   onEditingComplete: () => FocusScope.of(context).nextFocus(),
              // ),
              // TextField(
              //   controller: heightController,
              //   decoration: InputDecoration(labelText: 'Height (m)'),
              //   keyboardType: TextInputType.number,
              //   onChanged: (_) => _update(
              //       widthController: weightController,
              //       heightController: heightController,
              //       bmiController: bmiController),
              // ),
              // TextField(
              //   controller: bmiController,
              //   decoration: InputDecoration(labelText: 'BMI'),
              //   readOnly: true,
              // ),
              SizedBox(height: 50,),
              SocialIcon(
                width: 40,
                height: 40,
                linkPath: 'https://www.youtube.com/',
                iconPath: 'assets/flutter.png',
              ),
              Text('Get Address form latlong'),
              TextField(
                  controller: latitudeController,
                  decoration: InputDecoration(labelText: 'Latitude'),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _updateAddress(
                      latitudeController: latitudeController,
                      longitudeController: longitudeController,
                      address: address)),
              TextField(
                  controller: longitudeController,
                  decoration: InputDecoration(labelText: 'Longitude'),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _updateAddress(
                      latitudeController: latitudeController,
                      longitudeController: longitudeController,
                      address: address)),
              Text(
                address.value.toString(),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text('Get LatLong form Address'),
              TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  keyboardType: TextInputType.text,
                  onChanged: (_) => _updateLatLng(
                      addressController: addressController, lat: lat,lang: lan)),
              Text('${lat.value.toString()},${lan.value.toString()}'),
            ],
          ),
        ),
      ),
    );
  }
}
