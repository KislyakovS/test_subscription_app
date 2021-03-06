import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:subscription_tracker/models/subscription.dart';
import 'package:subscription_tracker/screens/serach_logo/serach_logo_screen.dart';
import 'package:subscription_tracker/widgets/image_subscription.dart';
import 'package:subscription_tracker/widgets/widgets.dart';

class FormItem {
  final String label;
  final Widget field;

  FormItem({required this.label, required this.field});
}

class FormSubscriptionScreen extends StatefulWidget {
  final Subscription? subscription;

  final List<FormItem> formItems = [
    FormItem(
      label: 'Title',
      field: CupertinoTextField(
        placeholder: 'Hello',
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
        ),
      ),
    ),
    FormItem(
      label: 'Price',
      field: CupertinoTextField(
        placeholder: 'Hello',
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
        ),
      ),
    ),
    FormItem(
      label: 'Currency',
      field: CupertinoTextField(
        placeholder: 'Hello',
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
        ),
      ),
    ),
    FormItem(
      label: 'Period',
      field: CupertinoTextField(
        placeholder: 'Hello',
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
        ),
      ),
    ),
    FormItem(
      label: 'Date',
      field: CupertinoTextField(
        placeholder: 'Hello',
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
        ),
      ),
    ),
    FormItem(
      label: 'Notifications',
      field: CupertinoTextField(
        placeholder: 'Hello',
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
        ),
      ),
    ),
  ];

  FormSubscriptionScreen({Key? key, this.subscription}) : super(key: key);

  @override
  _FormSubscriptionScreenState createState() => _FormSubscriptionScreenState();
}

class _FormSubscriptionScreenState extends State<FormSubscriptionScreen> {
  final double targetElevation = 3;
  double _elevation = 0;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    double newElevation = _controller.offset > 1 ? targetElevation : 0;
    if (_elevation != newElevation) {
      setState(() {
        _elevation = newElevation;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_scrollListener);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: _elevation,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.subscription?.title ?? 'New subscription',
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _controller,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Image(src: widget.subscription?.image),
                const SizedBox(height: 50),
                ...widget.formItems
                    .asMap()
                    .entries
                    .map((item) => _RowForm(
                          item: item.value,
                          isShowDivider:
                              item.key != widget.formItems.length - 1,
                        ))
                    .toList()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String? src;

  const _Image({Key? key, this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (src != null) {
      return ImageSubscription(src: src!, size: 150);
    }

    return IconButton(
        iconSize: 150,
        color: Colors.black,
        onPressed: () {
          showModalBottomSheet<DraggableScrollableSheet>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) {
              return SearchLogoScreen();
            },
          );
        },
        icon: const Icon(
          Icons.add_photo_alternate_outlined,
        ));
  }
}

class _RowForm extends StatelessWidget {
  final FormItem item;
  final bool isShowDivider;

  const _RowForm({Key? key, required this.item, required this.isShowDivider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(item.label), Expanded(child: item.field)],
        ),
        if (isShowDivider) Divider(color: Colors.grey[400]),
      ],
    );
  }
}
