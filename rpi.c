#include "../PJ_RPI/PJ_RPI.c"

int mapping_available(){
    return !(map_peripheral(&gpio) == -1);
}

void input_gpio(int port){
    if(mapping_available())
        INP_GPIO(port);
}

void output_gpio(int port){
    if(mapping_available()){
        INP_GPIO(port);
        OUT_GPIO(port);
    }
}

void set_gpio(int port, int value){
    if(mapping_available())
        if(value)
            GPIO_SET = 1 << port;
        else
            GPIO_CLR = 1 << port;
}

void set_gpio_low(int port){
    set_gpio(port, 0);
}

void set_gpio_high(int port){
    set_gpio(port, 1);
}
