var txt = text;
var index = 48;

for (var i = 0; i < string_length(txt); i++)
{
    index += 32;
    
    if ((index % 850) == 0)
    {
        index = 48;
        borderTargetpos -= 100;
        borderscaleYmult += 0.87;
    }
}
