/**
 * Created by Chelsea on 5/1/2014.
 */
package com.whatanadventure.framework.data
{
    public interface IFetcher
    {
        function get isFetching():Boolean;

        function onComplete():void;
    }
}
