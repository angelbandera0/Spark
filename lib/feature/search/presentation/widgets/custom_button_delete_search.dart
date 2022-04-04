import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/feature/account_management/presentation/pages/home_page.dart';
import 'package:sparkz/feature/search/presentation/bloc/delete_unparked/delete_unparked_bloc.dart';

class DeleteSearchButton extends StatefulWidget {
  const DeleteSearchButton({
    Key? key,
    required this.onHandleDelete,
  }) : super(key: key);

  final int onHandleDelete;

  @override
  _DeleteSearchButtonState createState() => _DeleteSearchButtonState();
}

class _DeleteSearchButtonState
    extends StateWithBloC<DeleteSearchButton, DeleteUnparkedBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return BlocConsumer<DeleteUnparkedBloc, DeleteUnparkedState>(
        listener: (context, state) {
      if (state is DeleteUnparkedSuccessState) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      return;
    }, builder: (context, state) {
      return CustomUpperButton(
        isLeading: false,
        onPressed: () {
          context
              .read<DeleteUnparkedBloc>()
              .add(DeleteUnparkedSentEvent(widget.onHandleDelete));
          //
        },
        icon: Icons.search_off,
      );
    });
  }
}
