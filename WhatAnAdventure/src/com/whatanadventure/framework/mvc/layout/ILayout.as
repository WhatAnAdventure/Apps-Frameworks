/**
 * Created by Chelsea on 5/10/2014.
 */
package com.whatanadventure.framework.mvc.layout
{
    import feathers.core.FeathersControl;

    public interface ILayout
    {
        function init(view:FeathersControl):void;

        function updateLayout():void;

        function get mvcLayoutData():MVCLayoutData;
    }
}
