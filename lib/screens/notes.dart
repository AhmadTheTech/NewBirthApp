import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_birth/widget/card.dart';
import 'package:new_birth/widget/drawer.dart';
import 'package:new_birth/widget/textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SermonsNotes extends StatefulWidget {
  const SermonsNotes({super.key});

  @override
  State<SermonsNotes> createState() => _SermonsNotesState();
}

class _SermonsNotesState extends State<SermonsNotes> {
  List<Map<String, String>> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storedNotes = prefs.getStringList('notes');
    if (storedNotes != null) {
      setState(() {
        notes = storedNotes.map((note) {
          final parts = note.split('||');
          return {
            'title': parts[0],
            'speaker': parts[1],
            'passage': parts[2],
            'content': parts[3],
          };
        }).toList();
      });
    }
  }

  void _showAchievement(BuildContext context, String title, String subtitle,
      {bool isError = false}) {
    AchievementView(
      title: title,
      subTitle: subtitle,
      isCircle: true,
      icon: Icon(
        isError ? Icons.error : Icons.check,
        color: Colors.white,
      ),
      duration: Duration(seconds: 3),
      color: isError ? Colors.red : Colors.green,
      textStyleTitle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      textStyleSubTitle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14,
      ),
      alignment: Alignment.topCenter,
    ).show(context);
  }

  Future<void> _addNote(
      String title, String speaker, String passage, String content) async {
    final prefs = await SharedPreferences.getInstance();
    notes.add({
      'title': title,
      'speaker': speaker,
      'passage': passage,
      'content': content
    });
    await _saveNotes(prefs);
    setState(() {});
  }

  Future<void> _deleteNote(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notes.removeAt(index);
      _showAchievement(context, 'Success', 'Note Deleted Successfully');
    });
    await _saveNotes(prefs);
  }

  Future<void> _saveNotes(SharedPreferences prefs) async {
    final List<String> storedNotes = notes
        .map((note) =>
            '${note['title']}||${note['speaker']}||${note['passage']}||${note['content']}')
        .toList();
    await prefs.setStringList('notes', storedNotes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff5f0cfb),
                Color(0xff982aea),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewSermonsNotes(
                    onSave: (title, speaker, passage, content) =>
                        _addNote(title, speaker, passage, content),
                  ),
                ),
              );
            },
          ),
        ],
        toolbarHeight: 60,
        title: Text(
          "Sermons Notes",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: notes.isEmpty
          ? Center(
              child: Text(
                "No data",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotesDetail(
                                  title: notes[index]['title']!,
                                  speaker: notes[index]['speaker']!,
                                  passage: notes[index]['passage']!,
                                  content: notes[index]['content']!,
                                  onDelete: () => _deleteNote(index))));
                    },
                    child: CardWidget(
                      title: notes[index]['title']!,
                      info: notes[index]['content']!,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class NewSermonsNotes extends StatelessWidget {
  final Function(String, String, String, String) onSave;

  const NewSermonsNotes({super.key, required this.onSave});

  void _showAchievement(BuildContext context, String title, String subtitle,
      {bool isError = false}) {
    AchievementView(
      title: title,
      subTitle: subtitle,
      isCircle: true,
      duration: Duration(seconds: 3),
      icon: Icon(
        isError ? Icons.error : Icons.check,
        color: Colors.white,
      ),
      color: isError ? Colors.red : Colors.green,
      textStyleTitle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      textStyleSubTitle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14,
      ),
      alignment: Alignment.topCenter,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController speakerController = TextEditingController();
    TextEditingController passageController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff5f0cfb),
                Color(0xff982aea),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        toolbarHeight: 60,
        title: Text(
          "New Sermons Notes",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(
              children: [
                InputFields(
                  title: 'Title',
                  borderRadius: 10,
                  isPass: false,
                  controller: titleController,
                ),
                SizedBox(height: 18),
                InputFields(
                  title: 'Speaker',
                  borderRadius: 10,
                  isPass: false,
                  controller: speakerController,
                ),
                SizedBox(height: 18),
                InputFields(
                  title: 'Passage',
                  borderRadius: 10,
                  isPass: false,
                  controller: passageController,
                ),
                SizedBox(height: 18),
                InputFields(
                  title: 'Content',
                  borderRadius: 10,
                  isPass: false,
                  contentPadding: 50,
                  controller: contentController,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: ButtonWidget(
          color: LinearGradient(
            colors: [
              Color(0xff5f0cfb),
              Color(0xff982aea),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          title: 'Save Notes',
          borderRadius: 10,
          textColor: Colors.white,
          onTap: () {
            if (titleController.text.isEmpty ||
                speakerController.text.isEmpty ||
                passageController.text.isEmpty ||
                contentController.text.isEmpty) {
              _showAchievement(context, 'Oops!', 'Please Fill All Fields',
                  isError: true);
              return;
            }

            onSave(
              titleController.text,
              speakerController.text,
              passageController.text,
              contentController.text,
            );
            _showAchievement(context, 'Success!', 'Note Saved Successfully');
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

class NotesDetail extends StatefulWidget {
  final String title;
  final String speaker;
  final String content;
  final String passage;
  final VoidCallback onDelete;
  const NotesDetail({
    super.key,
    required this.title,
    required this.speaker,
    required this.content,
    required this.passage,
    required this.onDelete,
  });

  @override
  State<NotesDetail> createState() => _NotesDetailState();
}

class _NotesDetailState extends State<NotesDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff5f0cfb),
                Color(0xff982aea),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        toolbarHeight: 60,
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardWidget(title: 'Title', info: widget.title),
              CardWidget(title: 'Speaker', info: widget.speaker),
              CardWidget(title: 'Passage', info: widget.passage),
              CardWidget(title: 'Content', info: widget.content),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: ButtonWidget(
          color: LinearGradient(
            colors: [
              Color(0xff5f0cfb),
              Color(0xff982aea),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          title: "Delete Notes",
          borderRadius: 10,
          textColor: Colors.white,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Delete"),
                  content: Text("Are you sure you want to delete this note?"),
                  actions: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text("Delete"),
                      onPressed: () {
                        widget.onDelete();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
