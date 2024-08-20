function onEvent(e:EventGameEvent)
{
    if (e.event.name == "Change Default Zoom")
    {
        defaultCamZoom = Std.parseFloat(e.event.params[0]);
    }
}