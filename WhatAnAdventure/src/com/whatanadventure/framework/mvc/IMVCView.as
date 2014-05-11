/**
 * Created by Chelsea on 5/5/2014.
 */
package com.whatanadventure.framework.mvc
{
    import com.whatanadventure.framework.mvc.layout.ILayout;

    import starling.events.Event;

    public interface IMVCView
    {
        function reinitialize():void;

        function set controller(controller:MVCController):void;
        function get controller():MVCController;

        function set mvcLayout(value:ILayout):void;
        function get mvcLayout():ILayout;

        function get viewId():String;

        function onModelChange(event:Event):void;

        function addModels():void;
    }
}
