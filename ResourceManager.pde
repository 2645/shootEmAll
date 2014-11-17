import java.util.Map;

class ResourceManager {
  
  HashMap<String, PImage> cache = new HashMap<String, PImage>();
  
  ResourceManager(){}
  
  PImage get(String path){
    if(cache.containsKey(path)){
       return cache.get(path);
    }
    PImage file = loadImage(path);
    cache.put(path, file);
    return file;
  }
  
}
