import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/view/home/home.dart';
import 'package:pbp_widget_a_klmpk4/view/home/pay.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pbp_widget_a_klmpk4/entity/cart.dart';
import 'package:pbp_widget_a_klmpk4/client/CartClient.dart';

class BookCarPage extends StatefulWidget {
  BookCarPage(
      {Key? key,
      this.id,
      required this.id_user,
      required this.id_car,
      required this.carName,
      required this.pickup_date,
      required this.return_date,
      required this.location})
      : super(key: key);

  final int? id, id_car, id_user;
  int? day, price;
  String carName, pickup_date, return_date, location;

  @override
  _BookCarPageState createState() => _BookCarPageState();
}

class _BookCarPageState extends State<BookCarPage> {
  int _selectedCar = 1;
  String _startDateTime = '';
  final String _endDateTime = '';
  String _pickupLocation = '';

  TextEditingController pickupDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController controllerDay = TextEditingController();

  int? id_car;
  DateTime? pickupDate;
  DateTime? returnDate;
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  Map<String, int> carValues = {
    'Porsche GT 911': 1,
    'Ferrari F40': 2,
    'Aston Valkyrie': 3,
    'Mercedes AMG': 4,
    'Toyota Supra': 5,
    'McLaren Senna': 6,
  };

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    print(widget.id);
    
    locationController = TextEditingController(text: widget.location);
  }

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition();
  }

  _getAdressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemarks[0];

      setState(() {
        locationController.text =
            "${place.street}, ${place.subLocality}, ${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<void> _selectPickupDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: pickupDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != pickupDate)
      setState(() {
        pickupDate = picked;
        pickupDateController.text = "${pickupDate!.toLocal()}";
      });
  }

  Future<void> _selectReturnDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: returnDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != returnDate)
      setState(() {
        returnDate = picked;
        returnDateController.text = "${returnDate!.toLocal()}";
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    'Date & Time',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Car',
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<int>(
                    value: _selectedCar,
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedCar = newValue;
                          id_car = _selectedCar;
                        });
                      }
                    },
                    items: const <DropdownMenuItem<int>>[
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text('Porsche GT 911'),
                      ),
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text('Ferrari F40'),
                      ),
                      DropdownMenuItem<int>(
                        value: 3,
                        child: Text('Aston Valkyrie'),
                      ),
                      DropdownMenuItem<int>(
                        value: 4,
                        child: Text('Mercedes AMG'),
                      ),
                      DropdownMenuItem<int>(
                        value: 5,
                        child: Text('Toyota Supra'),
                      ),
                      DropdownMenuItem<int>(
                        value: 6,
                        child: Text('McLaren Senna'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pick-up Location',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: locationController,
                    onTap: () async {
                      _currentLocation = await _getCurrentLocation();
                      await _getAdressFromCoordinates();
                    },
                    decoration: const InputDecoration(
                      hintText: 'Select Your Location',
                      suffixIcon: Icon(Icons.location_on),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pickup Date',
                    style: TextStyle(fontSize: 18),
                  ),
                  InkWell(
                    onTap: () => _selectPickupDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                      child: pickupDate == null
                          ? const Text('Select Date')
                          : Text(
                              "${pickupDate!.toLocal()}".split(' ')[0],
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Return Date',
                    style: TextStyle(fontSize: 18),
                  ),
                  InkWell(
                    onTap: () => _selectReturnDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                      child: returnDate == null
                          ? const Text('Select Date')
                          : Text(
                              "${returnDate!.toLocal()}".split(' ')[0],
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 100.0,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(450, 40),
                    backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                  ),
                  onPressed: () async {
                    if (widget.id == null) {
                      await addCart();
                    } else {
                      print(widget.id);
                      await editCart(widget.id!);
                    }
                    setState(() {
                      _startDateTime = _startDateTime.toString();
                      _pickupLocation = '';
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ),
                    );
                  },
                  child: const Text('Create'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addCart() async {
    final int idCar = _selectedCar;
    const int pricePerDay = 500000;
    _currentLocation = await _getCurrentLocation();

    String getCarName(int idCar) {
      switch (idCar) {
        case 1:
          return 'Porsche GT 911';
        case 2:
          return 'Ferrari F40';
        case 3:
          return 'Aston Markin Valkyrie';
        case 4:
          return 'Mercedes AMG';
        case 5:
          return 'Toyota Supra';
        case 6:
          return 'McLaren Senna';
        default:
          return ''; // Handle the case when idCar is not found
      }
    }

    final String selectedCarName = getCarName(idCar);

    final int id_user = await CartClient.getUserId();
    try {
      // Calculate the difference in days between returnDate and pickupDate
      final Duration difference = returnDate!.difference(pickupDate!);
      final int day = difference.inDays;

      // Calculate the total price based on the number of days
      final int totalPrice = day * pricePerDay;
      Cart cart = Cart(
        id_user: id_user,
        id_car: idCar,
        carName: selectedCarName,
        day: day,
        price: totalPrice,
        pickup_date: pickupDate?.toIso8601String() ?? '',
        return_date: returnDate?.toIso8601String() ?? '',
        location: locationController.text,
      );

      CartClient.create(cart);
    } catch (e) {
      print('Error adding cart item: $e');
    }
  }

  Future<void> editCart(int id) async {
    final int idCar = _selectedCar;
    const int pricePerDay = 500000;
    _currentLocation = await _getCurrentLocation();

    String getCarName(int idCar) {
      switch (idCar) {
        case 1:
          return 'Porsche';
        case 2:
          return 'Ferrari';
        case 3:
          return 'Aston';
        case 4:
          return 'Mercy';
        case 5:
          return 'Supra';
        case 6:
          return 'McLaren';
        default:
          return ''; // Handle the case when idCar is not found
      }
    }

    final String selectedCarName = getCarName(idCar);

    final int id_user = await CartClient.getUserId();
    try {
      // Calculate the difference in days between returnDate and pickupDate
      final Duration difference = returnDate!.difference(pickupDate!);
      final int day = difference.inDays;

      // Calculate the total price based on the number of days
      final int totalPrice = day * pricePerDay;
      Cart cart = Cart(
        id: id,
        id_user: id_user,
        id_car: idCar,
        carName: selectedCarName,
        day: day,
        price: totalPrice,
        pickup_date: pickupDate?.toIso8601String() ?? '',
        return_date: returnDate?.toIso8601String() ?? '',
        location: locationController.text,
      );

      CartClient.update(cart);
    } catch (e) {
      print('Error adding cart item: $e');
    }
  }
}
