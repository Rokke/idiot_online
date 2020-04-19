import 'package:flutter/material.dart';
import 'package:idiot_online/models/constants.dart';
import 'package:idiot_online/models/player.dart';

class RegisterPlayer extends StatefulWidget {
  final Player player;
  final Function onRemove;
  RegisterPlayer(this.player, {@required this.onRemove, Key key}) : super(key: key);

  @override
  _RegisterPlayerState createState() => _RegisterPlayerState();
}

class _RegisterPlayerState extends State<RegisterPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('RegisterPlayer - build');
//    print('RegisterPlayer build ${jsonEncode(_colors)}');
    return Container(
      color: widget.player.color,
      height: 80,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: TextFormField(
              initialValue: widget.player.name,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                ),
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Ditt navn',
                labelText: 'Navn',
              ),
              onChanged: (val) => widget.player.name = val,
              validator: (String value) => value.length > 4 ? 'Du må legge inn et langt nok navn' : null,
            ),
          ),
          DropdownButton(
              style: TextStyle(color: Colors.white),
              dropdownColor: widget.player.color,
              autofocus: false,
              elevation: 2,
              value: widget.player.color,
              items: personColorMap.entries
                  .map((e) => DropdownMenuItem(
                        child: Text(e.key),
                        value: e.value,
                      ))
                  .toList(),
              onChanged: (val) => setState(() {
                    print('val: $val');
                    widget.player.color = val;
                  })),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () => widget.onRemove(),
            autofocus: false,
          ),
        ],
      ),
    );
  }
}
