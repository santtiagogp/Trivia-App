import 'package:flutter/material.dart';

class SelectionWidget extends StatefulWidget {
  const SelectionWidget({
    super.key,
    required this.items,
    required this.title,
    required this.onSelection
  });

  final List<String> items;
  final String title;
  final void Function(String value) onSelection; 

  @override
  State<SelectionWidget> createState() => _SelectionWidgetState();
}

class _SelectionWidgetState extends State<SelectionWidget> {

  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text(widget.title),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(40)
          ),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            children: [
              PageView.builder(
                itemCount: widget.items.length,
                controller: _controller,
                allowImplicitScrolling: false,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  widget.onSelection(widget.items[index]);
                  return Center(
                    child: Text(widget.items[index])
                  );
                },
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => _controller.animateToPage(
                        _controller.page!.toInt() - 1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear
                      ),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    IconButton(
                      onPressed: () => _controller.animateToPage(
                        _controller.page!.toInt() + 1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear
                      ),
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}