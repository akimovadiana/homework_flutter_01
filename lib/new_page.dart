import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final newState = _NewPageState();

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() {
    return newState;
  }
}

class _NewPageState extends State<NewPage> {
  late MainPageState state;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    state = DefaultState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    if (state.runtimeType == DefaultState) {
      return getDefaultState();
    }
    if (state.runtimeType == ErrorState) {
      return getErrorState();
    }
    if (state.runtimeType == LoadingState) {
      return const CircularProgressIndicator();
    }
    if (state.runtimeType == LoadedState) {
      final data = (state as LoadedState).age;
      Map dataMap = jsonDecode(data);
      final int age = dataMap['age'];
      final String ageStr = age.toString();
      return Text(
        ageStr,
        style: const TextStyle(
          fontSize: 20,
        ),
      );
    }
    return const Placeholder();
  }

  Widget getDefaultState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            border: OutlineInputBorder(),
            labelText: 'Name',
          ),
          textCapitalization: TextCapitalization.words,
        ),
      ],
    );
  }

  Widget getErrorState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            border: OutlineInputBorder(),
            labelText: 'Name',
            errorText: 'This field is required and cannot be empty',
          ),
          textCapitalization: TextCapitalization.words,
        ),
      ],
    );
  }

  void getResponse() async {
    if (_controller.text.isEmpty) {
      setState(() {
        state = ErrorState();
      });
    } else {
      setState(() {
        state = LoadingState();
      });
      final response = await http.get(Uri.parse('https://api.agify.io/?name=${_controller.text}'));
      setState(() {
        state = LoadedState(response.body);
      });
    }
  }
}

class MainPageState {
}

class DefaultState extends MainPageState {
}

class ErrorState extends MainPageState {
}

class LoadingState extends MainPageState {
}

class LoadedState extends MainPageState {
  final String age;
  LoadedState(this.age);
}