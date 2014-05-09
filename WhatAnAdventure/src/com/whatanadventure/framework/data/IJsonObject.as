/**
 * Created by Chelsea on 5/8/2014.
 */
package com.whatanadventure.framework.data
{
    public interface IJsonObject
    {
        function toJSON():Object;
        function fromJSON(jsonData:Object):void;
    }
}
