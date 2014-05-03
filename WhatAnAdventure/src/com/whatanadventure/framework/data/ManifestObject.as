/**
 * Created by Chelsea on 5/3/2014.
 */
package com.whatanadventure.framework.data
{
    public class ManifestObject
    {
        public var path:String;
        public var type:String;
        public var modelClassName:String;

        public function ManifestObject(properties:Object)
        {
            for (var propertyName:String in properties)
            {
                if (hasOwnProperty(propertyName))
                {
                    this[propertyName] = properties[propertyName];
                }
            }
        }
    }
}
