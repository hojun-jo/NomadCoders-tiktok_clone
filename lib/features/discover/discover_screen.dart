import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  bool _isWriting = false;

  void _onSearchChanged(String value) {}

  void _onSearchSubmitted(String value) {}

  void _tabPressed(int index) {
    FocusScope.of(context).unfocus();
  }

  void _onClearTap() {
    _textEditingController.clear();
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      if (_textEditingController.text.isEmpty) {
        _isWriting = false;
      }
      if (_isWriting == false && _textEditingController.text.isNotEmpty) {
        _isWriting = true;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          title: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    right: Sizes.size14,
                  ),
                  child: FaIcon(FontAwesomeIcons.chevronLeft),
                ),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          Sizes.size5,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDarkMode(context)
                          ? Colors.grey.shade800
                          : Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size10,
                      ),
                      prefixIcon: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: Sizes.size20,
                          ),
                        ],
                      ),
                      prefixIconColor: isDarkMode(context)
                          ? Colors.grey.shade200
                          : Colors.grey.shade800,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                          right: Sizes.size14,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_isWriting)
                              GestureDetector(
                                onTap: _onClearTap,
                                child: FaIcon(
                                  FontAwesomeIcons.solidCircleXmark,
                                  color: Colors.grey.shade500,
                                  size: Sizes.size20,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: Sizes.size14,
                  ),
                  child: FaIcon(FontAwesomeIcons.sliders),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            onTap: _tabPressed,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: 20,
              padding: const EdgeInsets.all(
                Sizes.size6,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 20,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size4),
                      ),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/images/placeholder.jpg",
                          image:
                              "https://images.unsplash.com/photo-1729508895264-d61e3f6587fa?q=80&w=3119&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        ),
                      ),
                    ),
                    Gaps.v10,
                    const Text(
                      "This is a very long caption for my tiktok that I am upload just now currently.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Sizes.size16 + Sizes.size2,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                    Gaps.v8,
                    // if (constraints.maxWidth < 200 ||
                    //     constraints.maxWidth > 250)
                    DefaultTextStyle(
                      style: TextStyle(
                        color: isDarkMode(context)
                            ? Colors.grey.shade300
                            : Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/29245056",
                            ),
                          ),
                          Gaps.h4,
                          const Expanded(
                            child: Text(
                              "My avatar is going to be very long",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Gaps.h4,
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size16,
                            color: Colors.grey.shade600,
                          ),
                          Gaps.h2,
                          const Text(
                            "2.5M",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
