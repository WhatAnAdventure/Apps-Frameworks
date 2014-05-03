/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.mvc
{
    public interface IMVCModel
    {
        function toJSON():Object;
        function fromJSON(data:Object):void;

        function setProperties(properties:Object):void;
    }
}
