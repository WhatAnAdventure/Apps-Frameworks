/**
 * Created by Chelsea on 5/25/2014.
 */
package com.whatanadventure.framework.util
{
    public class ObjectUtil
    {
        public function ObjectUtil()
        {
        }

        public static function copy(obj:Object):Object
        {
            var result:Object = {};

            for (var key:String in obj)
            {
                result[key] = obj[key];
            }

            return result;
        }
    }
}
