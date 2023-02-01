import 'package:flutter/material.dart';

class SettingsPopup extends StatefulWidget {
  final Function(String, String) onValuesSubmitted;
  const SettingsPopup({super.key, required this.onValuesSubmitted});

  @override
  State<SettingsPopup> createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  final _formKey = GlobalKey<FormState>();
  final _ipController = TextEditingController();
  final _portController = TextEditingController();
  static String _ip = '';
  static String _port = '';

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SizedBox(
              height: 280,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 190,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _ipController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'IP cannot be empty';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'IP',
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            controller: _portController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Port cannot be empty';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Port',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              _ipController.clear();
                              _portController.clear();
                            },
                            child: const Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _ip = _ipController.text;
                                _port = _portController.text;
                                widget.onValuesSubmitted(_ip, _port);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
