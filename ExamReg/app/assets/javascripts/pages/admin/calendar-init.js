var scheduleURL = '/admin/api/room-schedule/';

!function($) {
    "use strict";

    var CalendarPage = function() {};
    var eventArray = [];
    $.ajax({
        url: scheduleURL+room_id,
        type: 'GET',
        async: false,
        data: { Id: 1 },
        success: function (data) {
            $.each(data, function (i, v) {
                eventArray.push({
                        "title": v.title,
                        "start": v.start,
                        "end": v.end
                    });
            });
            // console.log(room_id);
            // console.log(eventArray)
        },
        error: function (xhr, err) {
            alert("readyState: " + xhr.readyState + "\nstatus: " + xhr.status);
            alert("responseText: " + xhr.responseText);
        }
    });

    CalendarPage.prototype.init = function() {
        //checking if plugin is available
        if ($.isFunction($.fn.fullCalendar)) {
            /* initialize the external events */
            $('#external-events .fc-event').each(function() {
                // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
                // it doesn't need to have a start or end
                var eventObject = {
                    title: $.trim($(this).text()) // use the element's text as the event title
                };

                // store the Event Object in the DOM element so we can get to it later
                $(this).data('eventObject', eventObject);

                // make the event draggable using jQuery UI
                $(this).draggable({
                    zIndex: 999,
                    revert: true, // will cause the event to go back to its
                    revertDuration: 0 //  original position after the drag
                });

            });
            
            /* initialize the calendar */
            $('#calendar').fullCalendar({
                timeZone: 'local',
                agendaEventMinHeight: 200,
                defaultView: 'agendaWeek',
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'agendaWeek,month'
                },
                editable: false,
                eventLimit: true, // allow "more" link when too many events
                droppable: false, // this allows things to be dropped onto the calendar !!!
                draggable: false,
                events: eventArray
            });
        }
        else {
            alert("Calendar plugin is not installed");
        }
    },
    //init
    $.CalendarPage = new CalendarPage, $.CalendarPage.Constructor = CalendarPage
}(window.jQuery),

//initializing 
function($) {
    "use strict";
    $.CalendarPage.init()
}(window.jQuery);


