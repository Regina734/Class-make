import 'package:flutter/material.dart';
import 'package:stockage_app/ajouttaches.dart';
import 'package:table_calendar/table_calendar.dart';

class TachesPage extends StatefulWidget {
  @override
  _TachesPageState createState() => _TachesPageState();
}

class _TachesPageState extends State<TachesPage> {
  DateTime selectedDay = DateTime(2023, 11, 17);
  DateTime focusedDay = DateTime(2023, 11, 17);
  CalendarFormat calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 239, 239),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildWeekCalendar(),
            Expanded(
              child: _buildEventsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '17 Novembre',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Aujourd\'hui,',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AjouteTachesPage()));
              print('Ajouter un événement');
            },
            icon: Icon(Icons.add, color: Colors.white, size: 20),
            label: Text('Ajouter'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: TableCalendar<Event>(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        calendarFormat: calendarFormat,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: false,
          leftChevronVisible: true,
          rightChevronVisible: true,
          headerPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          weekendStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          defaultTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          selectedTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF28A745),
          ),
          todayTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: Color(0xFF28A745),
                width: 3,
              ),
            ),
          ),
          todayDecoration: BoxDecoration(
            color: Colors.transparent,
          ),
          markersMaxCount: 3,
          markerDecoration: BoxDecoration(
            color: Color(0xFF28A745).withOpacity(0.7),
            shape: BoxShape.circle,
          ),
          markerMargin: EdgeInsets.symmetric(horizontal: 1),
          markerSize: 6,
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
          });
        },
        onFormatChanged: (format) {
          setState(() {
            calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          this.focusedDay = focusedDay;
        },
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    if (isSameDay(day, DateTime(2023, 11, 17))) {
      return [
        Event('Physique'),
        Event('Géographie'),
        Event('Travail à rendre'),
      ];
    }
    return [];
  }

  Widget _buildEventsList() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildEventItem(
            startTime: '9:30',
            endTime: '10:20',
            title: 'Physique',
            subtitle: 'Chapitre 3: Force',
            teacher: 'Idriss ADAM',
            platform: 'Google Meet',
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            icon: Icons.science,
          ),
          SizedBox(height: 20),
          _buildEventItem(
            startTime: '11:00',
            endTime: '11:50',
            title: 'Géographie',
            subtitle: 'Chapitre 12: Profile du sol',
            teacher: 'Jenifer Clark',
            platform: 'Zoom',
            colors: [Color(0xFFA8EDEA), Color(0xFFFED6E3)],
            icon: Icons.public,
            isLightBackground: true,
          ),
          SizedBox(height: 20),
          _buildEventItem(
            startTime: '12:20',
            endTime: '13:00',
            title: 'Travail à rendre',
            subtitle: 'Schéma régional',
            teacher: 'Alexa Tenorio',
            platform: 'Google Docs',
            colors: [Color(0xFFD299C2), Color(0xFFFEF9D7)],
            icon: Icons.assignment,
            isLightBackground: true,
          ),
        ],
      ),
    );
  }

  // WIDGET POUR CONSTRUIRE UN ÉLÉMENT D'ÉVÉNEMENT
  Widget _buildEventItem({
    required String startTime,
    required String endTime,
    required String title,
    required String subtitle,
    required String teacher,
    required String platform,
    required List<Color> colors,
    required IconData icon,
    bool isLightBackground = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Colonne des heures
        Container(
          width: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                startTime,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                endTime,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 20),

        // Ligne de timeline avec point
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: colors[0],
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 100,
              color: Colors.grey[300],
            ),
          ],
        ),

        SizedBox(width: 20),

        // Carte de l'événement
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre et icône
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color:
                            isLightBackground ? Colors.black87 : Colors.white,
                      ),
                    ),
                    Icon(
                      icon,
                      color: isLightBackground
                          ? Colors.black26
                          : Colors.white.withOpacity(0.3),
                      size: 24,
                    ),
                  ],
                ),

                SizedBox(height: 8),

                // Sous-titre
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: isLightBackground
                        ? Colors.black54
                        : Colors.white.withOpacity(0.9),
                  ),
                ),

                SizedBox(height: 15),

                // Informations du professeur
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          teacher.split(' ').map((e) => e[0]).join(''),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      teacher,
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            isLightBackground ? Colors.black87 : Colors.white,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // Plateforme
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: isLightBackground
                            ? Colors.black12
                            : Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      platform,
                      style: TextStyle(
                        fontSize: 13,
                        color:
                            isLightBackground ? Colors.black87 : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Event {
  final String title;

  Event(this.title);

  @override
  String toString() => title;
}
